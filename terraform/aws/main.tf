
provider "aws"{
    region = "us-east-1"
    profile = "terraform"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Random string for unique resources
resource "random_string" "random" {
  length  = 16
  lower   = true
  upper   = true
  numeric = true
  special = false
}

# Users

# 1.12 User which will never be logged in - leave enabled
# AMartinez
resource "aws_iam_user" "AMartinez" {
  name = "AMartinez"
  path = "/"
}

resource "aws_iam_access_key" "AMartinez" {
  user = aws_iam_user.AMartinez.name
}

# 1.12 User which will never be logged in - disable them
# BSmith
resource "aws_iam_user" "BSmith" {
  name = "BSmith"
  path = "/"
}

resource "aws_iam_access_key" "BSmith" {
  user = aws_iam_user.BSmith.name
}

# 1.13 User with multiple access keys and a console password
# GLee
resource "aws_iam_user" "GLee" {
  name = "GLee"
  path = "/"
}

resource "aws_iam_user_login_profile" "GLee" {
  user    = aws_iam_user.GLee.name
  pgp_key = <<KEY
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
x56X71E+wc34K/5IkeiNQAL7sA==
KEY
}

resource "aws_iam_access_key" "GLee" {
  user = aws_iam_user.GLee.name
}

resource "aws_iam_access_key" "GLee2" {
  user = aws_iam_user.GLee.name
}

# 1.15 Assign permissions directly to a user
# Permissions: 
# KJones
resource "aws_iam_user" "KJones" {
  name = "KJones"
  path = "/"
}

resource "aws_iam_access_key" "KJones" {
  user = aws_iam_user.KJones.name
}
# 1.16 User with full *:* permissions
# WAlexander
resource "aws_iam_user" "WAlexander" {
  name = "WAlexander"
  path = "/"
}

resource "aws_iam_access_key" "WAlexander" {
  user = aws_iam_user.WAlexander.name
}

resource "aws_iam_user_policy" "sans5x7ec2admin" {
  name = "sans5x7ec2admin"
  user = aws_iam_user.WAlexander.name


  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "aws:*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

# 1.17 Support role to manage incidents with AWS support [AWSSupportAccess role]
# JAllen
resource "aws_iam_user" "JAllen" {
  name = "JAllen"
  path = "/"
}

resource "aws_iam_access_key" "JAllen" {
  user = aws_iam_user.JAllen.name
}

#student read-only user
resource "aws_iam_user" "sans5x7readonly" {
  name = "sans5x7readonly"
  path = "/"
}

resource "aws_iam_access_key" "sans5x7readonly" {
  user = aws_iam_user.sans5x7readonly.name
}

resource "aws_iam_user_login_profile" "sans5x7readonlyPassword" {
  user     = aws_iam_user.sans5x7readonly.name
}

output "sans5x7readonlypassword" {
  value = aws_iam_user_login_profile.sans5x7readonlyPassword.password
}

output "sans5x7readonlysecret" {
  value = aws_iam_access_key.sans5x7readonly.secret
  sensitive = true
}

output "sans5x7readonlyid" {
  value = aws_iam_access_key.sans5x7readonly.id
}


#cloudquery.io user
resource "aws_iam_user" "cqio" {
  name = "cqio"
  path = "/"
}

resource "aws_iam_access_key" "cqio" {
  user = aws_iam_user.cqio.name
}

output "cqiosecret" {
  value = aws_iam_access_key.cqio.secret
  sensitive = true
}

output "cqioid" {
  value = aws_iam_access_key.cqio.id
}

#########################################
#Groups

#Group for cloudquery.io to access resources
resource "aws_iam_group" "cloudquery" {
  name = "cloudquery"
  path = "/"
}

resource "aws_iam_group_membership" "cloudquery" {
  name = "cloudquery.io"

  users = [
    aws_iam_user.cqio.name,
    aws_iam_user.sans5x7readonly.name,
  ]

  group = aws_iam_group.cloudquery.name
}


##############################################
# Map policies to groups

resource "aws_iam_group_policy_attachment" "cloudquery-readonly" {
  group      = aws_iam_group.cloudquery.name
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}

#############################################
# Password policy

resource "aws_iam_account_password_policy" "SANS5x7" {
  minimum_password_length        = 8
  require_lowercase_characters   = true
  require_numbers                = true
  require_uppercase_characters   = true
  require_symbols                = true
  allow_users_to_change_password = true
}

#############################################
# Access Analyzer
# 1.20 - Enable access analyzer for all regions

resource "aws_accessanalyzer_analyzer" "sans5x7analyzer" {
  analyzer_name = "sans5x7analyzer"
}

#############################################
# VPCs

resource "aws_vpc" "SEC557Main" {
  cidr_block = "10.55.0.0/16"
  tags = {
      Name = "SEC5X7 Main VPC"
  }
}

resource "aws_subnet" "Sec557WorkStationSubnet" {
    vpc_id     = aws_vpc.SEC557Main.id
    cidr_block = "10.55.7.0/26"

    tags = {
        Name = "Sec5X7WorkstationSubnet"
        "Business_Unit" = "IT/Networking"
    }
}

resource "aws_subnet" "Sec557ServerSubnet" {
    vpc_id     = aws_vpc.SEC557Main.id
    cidr_block = "10.55.7.64/26"

    tags = {
        Name = "Sec5X7ServerSubnet"
    }
}

resource "aws_subnet" "Sec557ManagementSubnet" {
    vpc_id     = aws_vpc.SEC557Main.id
    cidr_block = "10.55.7.128/26"

    tags = {
        Name = "Sec5X7ManagementSubnet"
        "Business_Unit" = "IT/Networking"
  }
}

resource "aws_subnet" "Sec557TestSubnet" {
    vpc_id     = aws_vpc.SEC557Main.id
    cidr_block = "10.55.7.192/26"

    tags = {
        Name = "Sec5X7TestSubnet"
        "Business_Unit" = "QA"
  }
}

resource "aws_vpc" "AUD507Main" {
    cidr_block = "10.50.0.0/16"
    tags = {
        Name = "AUD5X7 Main VPC"
        "Business_Unit" = "IT/Networking"
  }
}

#Common AMIs
#Ubuntu 20.04 EC2 Instance: ami-09e67e426f25ce0d7
#Microsoft Windows Server 2019 Base - ami-0b18ca1a93b538109

#Sample web server with some tags
#Network interface for the portal webserver
resource "aws_network_interface" "CustomerPortalWebServerNIC" {
    subnet_id = aws_subnet.Sec557ServerSubnet.id
    private_ips = ["10.55.7.68"]
    tags = {
        Name = "SEC5x7 Customer Portal Webserver NIC"
        "Business_Unit" = "IT/Networking"
    }
}

resource "aws_instance" "CustomerPortalWebserver"{
    ami = "ami-09e67e426f25ce0d7"
    instance_type = "t2.micro"
    network_interface{
        network_interface_id = aws_network_interface.CustomerPortalWebServerNIC.id
        device_index = 0
    }
    tags= {
        Name = "SEC557-Web1"
        "Business_Unit" = "Information Technology"
        "Classification" = "PII,PCI"
        "ProjectName" = "Customer Web Portal"
        "ProjectID" = "IT2022-1234"
    }
}

#Sample DB server with some tags
resource "aws_network_interface" "CustomerPortalDBServerNIC" {
    subnet_id = aws_subnet.Sec557ServerSubnet.id
    private_ips = ["10.55.7.69"]
    tags = {
        Name = "SEC5x7 Customer Portal Database NIC"
        "Business_Unit" = "IT/Networking"
    }
}

resource "aws_instance" "CustomerPortalDBServer"{
    ami = "ami-09e67e426f25ce0d7"
    instance_type = "t2.micro"
        network_interface{
        network_interface_id = aws_network_interface.CustomerPortalDBServerNIC.id
        device_index = 0
    }
    tags= {
        Name = "SEC557-DB1"
        "Business_Unit" = "Information Technology"
        "Classification" = "PII,PCI"
        "ProjectName" = "Customer Web Portal"
        "ProjectID" = "IT2021-1234"
        "SpecialTag" = "ClayWasHere"
    }
}

#Rogue resource without the standard tags. Name will make it easier to report on :) 
#On the wrong subnet
resource "aws_network_interface" "webdevNIC" {
    subnet_id = aws_subnet.Sec557WorkStationSubnet.id
    private_ips = ["10.55.7.15"]
}

resource "aws_eip" "webdevEIP" {
  vpc                       = true
  network_interface         = aws_network_interface.webdevNIC.id
  associate_with_private_ip = "10.55.7.15"
}


resource "aws_instance" "webdev"{
    ami = "ami-09e67e426f25ce0d7"
    instance_type = "t2.micro"
    network_interface{
        network_interface_id = aws_network_interface.webdevNIC.id
        device_index = 0
    }
    tags= {
        Name = "WebDev"
    }
}


###########################################################################################
# HashiCat
###########################################################################################



# terraform {
#   required_providers {
#     aws = {
#       source  = "hashicorp/aws"
#       version = "=3.42.0"
#     }
#   }
# }

# provider "aws" {
#   region  = var.region
# }

resource "aws_security_group" "hashicat" {
  name = "hashicat-security-group"

  vpc_id = aws_vpc.SEC557Main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
    prefix_list_ids = []
  }
}

resource "aws_internet_gateway" "hashicat" {
  vpc_id = aws_vpc.SEC557Main.id

  tags = {
  }
}

resource "aws_route_table" "hashicat" {
  vpc_id = aws_vpc.SEC557Main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.hashicat.id
  }
}

resource "aws_route_table_association" "hashicat" {
  subnet_id      = aws_subnet.Sec557TestSubnet.id
  route_table_id = aws_route_table.hashicat.id
}

resource "aws_eip" "hashicat" {
  instance = aws_instance.hashicat.id
  vpc      = true
}

resource "aws_eip_association" "hashicat" {
  instance_id   = aws_instance.hashicat.id
  allocation_id = aws_eip.hashicat.id
}

resource "aws_instance" "hashicat" {
  ami                         = "ami-09e67e426f25ce0d7"
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.hashicat.key_name
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.Sec557TestSubnet.id
  vpc_security_group_ids      = [aws_security_group.hashicat.id]

  tags = {
    Name = "Hashicat"
  }
}

# We're using a little trick here so we can run the provisioner without
# destroying the VM. Do not do this in production.

# If you need ongoing management (Day N) of your virtual machines a tool such
# as Chef or Puppet is a better choice. These tools track the state of
# individual files and can keep them in the correct configuration.

# Here we do the following steps:
# Sync everything in files/ to the remote VM.
# Set up some environment variables for our script.
# Add execute permissions to our scripts.
# Run the deploy_app.sh script.
resource "null_resource" "configure-cat-app" {
  depends_on = [aws_eip_association.hashicat]

  triggers = {
    build_number = timestamp()
  }

  provisioner "file" {
    source      = "files/"
    destination = "/home/ubuntu/"

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = tls_private_key.hashicat.private_key_pem
      host        = aws_eip.hashicat.public_ip
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
      "PLACEHOLDER=${var.placeholder} WIDTH=${var.width} HEIGHT=${var.height}  ./deploy_app.sh",
      "sudo apt -y install cowsay",
      "cowsay Mooooooooooo!",
      "cat /var/www/html/index.html",
      "ls -l /var/www/html/index.html"
    ]

    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = tls_private_key.hashicat.private_key_pem
      host        = aws_eip.hashicat.public_ip
    }
  }
}

resource "tls_private_key" "hashicat" {
  algorithm = "RSA"
}

locals {
  private_key_filename = "hashicat-ssh-key.pem"
}

resource "aws_key_pair" "hashicat" {
  key_name   = local.private_key_filename
  public_key = tls_private_key.hashicat.public_key_openssh
}


###########################################################################################

#S3 bucket with public read - set up by another dev
resource "aws_s3_bucket" "webdevBucket" {
    tags = {
        Name = "WebDevBucket"
    }
}

resource "aws_s3_bucket_acl" "webdevBucketAcl" {
  bucket = aws_s3_bucket.webdevBucket.id
  acl    = "public-read"
}

resource "aws_kms_key" "webdevBucketKey" {
  description             = "This key is used to encrypt the webdev bucket objects"
  deletion_window_in_days = 10
}

resource "aws_s3_bucket_server_side_encryption_configuration" "webdevBucketEncryption" {
   bucket = aws_s3_bucket.webdevBucket.bucket

   rule {
     apply_server_side_encryption_by_default {
       kms_master_key_id = aws_kms_key.webdevBucketKey.arn
       sse_algorithm     = "aws:kms"
     }
   }
 }

resource "aws_s3_bucket" "logbucket" {
}

resource "aws_s3_bucket_acl" "logbucketAcl" {
  bucket = aws_s3_bucket.logbucket.id
  acl    = "log-delivery-write"
}

#Cloud trail bucket
data "aws_caller_identity" "current" {}

resource "aws_cloudtrail" "sec557cloudTrail" {
    name                          = "CloudTrail-sec557-com"
    s3_bucket_name                = aws_s3_bucket.CloudTrailBucket.id
    s3_key_prefix                 = "prefix"
    include_global_service_events = true

    event_selector {
        read_write_type           = "All"
        include_management_events = true

        data_resource {
            type   = "AWS::S3::Object"
            values = ["arn:aws:s3:::"]
        }
    }
}

resource "aws_s3_bucket" "CloudTrailBucket" {
    force_destroy = true
}

resource "aws_s3_bucket_policy" "CloudTrailBucketPolicy" {
  bucket = aws_s3_bucket.CloudTrailBucket.id
    policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AWSCloudTrailAclCheck",
            "Effect": "Allow",
            "Principal": {
            "Service": "cloudtrail.amazonaws.com"
            },
            "Action": "s3:GetBucketAcl",
            "Resource": "${aws_s3_bucket.CloudTrailBucket.arn}"
        },
        {
            "Sid": "AWSCloudTrailWrite",
            "Effect": "Allow",
            "Principal": {
            "Service": "cloudtrail.amazonaws.com"
            },
            "Action": "s3:PutObject",
            "Resource": "${aws_s3_bucket.CloudTrailBucket.arn}/prefix/AWSLogs/${data.aws_caller_identity.current.account_id}/*",
            "Condition": {
                "StringEquals": {
                    "s3:x-amz-acl": "bucket-owner-full-control"
                }
            }
        }
    ]
}
POLICY
}

#Lambda Functions
#basicExecution role allows for uploading logs to CloudWatch
resource "aws_iam_role" "lambda_role" {
  name = "lambda_role"
  assume_role_policy = "${file("lambda/lambdaAssumeRolePolicy.json")}"
  managed_policy_arns = ["arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"]
}

resource "aws_lambda_function" "LambdaCalculator" {
  filename      = "lambda/PSWebCalculator.zip"
  function_name = "PSWebCalculator"
  role          = aws_iam_role.lambda_role.arn
  handler       = "PSWebCalculator::PSWebCalculator.Bootstrap::ExecuteFunction"

  # The filebase64sha256() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the base64sha256() function and the file() function:
  # source_code_hash = "${base64sha256(file("lambda_function_payload.zip"))}"
  source_code_hash = filebase64sha256("lambda/PSWebCalculator.zip")

  runtime = "dotnetcore3.1"
}
