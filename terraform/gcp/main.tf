terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "=3.68.0"
    }
  }
}

provider "google" {
  project = var.project
  region  = var.region
}

#Service account for the project with some bad bindings
resource "google_service_account" "demosvcaccount" {
  account_id   = "demosvcaccount"
  display_name = "Demo Service Account"
}

resource "google_project_iam_member" "datastore_owner_binding" {
  project = "${var.project}"
  role    = "roles/datastore.owner"
  member  = "serviceAccount:${google_service_account.demosvcaccount.email}"
}

resource "google_project_iam_member" "compute_admin_binding" {
  project = "${var.project}"
  role    = "roles/compute.admin"
  member  = "serviceAccount:${google_service_account.demosvcaccount.email}"
}

#Storage buckets
resource "google_storage_bucket" "demobucket" {
  name          = "sans-demo-bucket"
  location      = "US"
  force_destroy = true

  uniform_bucket_level_access = false
}

resource "google_storage_bucket_access_control" "public_rule" {
  bucket = google_storage_bucket.demobucket.name
  role   = "READER"
  entity = "allUsers"
}

resource "google_storage_bucket" "demobucket2" {
  name          = "sans-demo-bucket2"
  location      = "US"
  force_destroy = true

  uniform_bucket_level_access = true
}

# Hashicat compue resources
resource "google_compute_network" "hashicat" {
  name                    = "${var.prefix}-vpc-${var.region}"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "hashicat" {
  name          = "${var.prefix}-subnet"
  region        = var.region
  network       = google_compute_network.hashicat.self_link
  ip_cidr_range = var.subnet_prefix
}

resource "google_compute_firewall" "http-server" {
  name    = "${var.prefix}-default-allow-ssh-http"
  network = google_compute_network.hashicat.self_link

  allow {
    protocol = "tcp"
    ports    = ["22", "80", "443", "3389"]
  }

  // Allow traffic from everywhere to instances with an http-server tag
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["http-server"]
}

resource "tls_private_key" "ssh-key" {
  algorithm = "RSA"
  rsa_bits  = "4096"
}

resource "google_compute_instance" "hashicat" {
  name         = "${var.prefix}-hashicat"
  zone         = "${var.region}-b"
  machine_type = var.machine_type

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.hashicat.self_link
    access_config {
    }
  }

  metadata = {
    ssh-keys = "ubuntu:${chomp(tls_private_key.ssh-key.public_key_openssh)} terraform"
  }

  tags = ["http-server"]

  labels = {
    name = "hashicat"
  }
}


resource "google_compute_instance" "webdev" {
  name         = "${var.prefix}-webdev"
  zone         = "${var.region}-b"
  machine_type = var.machine_type

  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2004-lts"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.hashicat.self_link
    access_config {
    }
  }

  metadata = {
    ssh-keys = "ubuntu:${chomp(tls_private_key.ssh-key.public_key_openssh)} terraform"
  }

  tags = ["dev-http-server"]

  labels = {
    name = "webdev"
  }
}

resource "null_resource" "configure-cat-app" {
  depends_on = [
    google_compute_instance.hashicat,
  ]

  triggers = {
    build_number = timestamp()
  }

  provisioner "file" {
    source      = "files/"
    destination = "/home/ubuntu/"

    connection {
      type        = "ssh"
      user        = "ubuntu"
      timeout     = "300s"
      private_key = tls_private_key.ssh-key.private_key_pem
      host        = google_compute_instance.hashicat.network_interface.0.access_config.0.nat_ip
    }
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt -y update",
      "sleep 15",
      "sudo apt -y update",
      "sudo apt -y install apache2",
      "sudo systemctl start apache2",
      "sudo chown -R ubuntu:ubuntu /var/www/html",
      "chmod +x *.sh",
      "PLACEHOLDER=${var.placeholder} WIDTH=${var.width} HEIGHT=${var.height} PREFIX=${var.prefix} ./deploy_app.sh",
      "sudo apt -y install cowsay",
      "cowsay Mooooooooooo!",
      "cat /var/www/html/index.html",
      "ls -l /var/www/html/index.html"
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      timeout     = "300s"
      private_key = tls_private_key.ssh-key.private_key_pem
      host        = google_compute_instance.hashicat.network_interface.0.access_config.0.nat_ip
    }
  }
}
