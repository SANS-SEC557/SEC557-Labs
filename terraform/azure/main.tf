terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.60.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.15.0"
    }
  }
}

provider "azurerm" {
  features {}
}

provider "azuread" {
  tenant_id = "9e7654e8-9d5b-42ab-a107-c1f3de434b0d"
}

resource "azurerm_resource_group" "myresourcegroup" {
  name     = "${var.prefix}-rg"
  location = var.location

  tags = {
    environment = "Production"
    business_unit = "SANSDemo"
  }
}


resource "azurerm_virtual_network" "vnet" {
  name                = "${var.prefix}-vnet"
  location            = azurerm_resource_group.myresourcegroup.location
  address_space       = [var.address_space]
  resource_group_name = azurerm_resource_group.myresourcegroup.name
}

resource "azurerm_subnet" "subnet" {
  name                 = "${var.prefix}-subnet"
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name  = azurerm_resource_group.myresourcegroup.name
  address_prefixes     = [var.subnet_prefix]
}

################## Extra network created by devs###########

resource "azurerm_resource_group" "myextraresourcegroup" {
  name     = "${var.prefix}test-rg"
  location = var.extralocation

  tags = {
    environment = "Dev"
    business_unit = "Testing - temporary"
  }

}

resource "azurerm_virtual_network" "vnettest" {
  name                = "${var.prefix}test-vnet"
  location            = azurerm_resource_group.myextraresourcegroup.location
  address_space       = [var.address_space2]
  resource_group_name = azurerm_resource_group.myextraresourcegroup.name

  tags = {
    environment = "Dev"
    business_unit = "Testing - temporary"
  }
}

resource "azurerm_subnet" "subnettest" {
  name                 = "${var.prefix}test-subnet"
  virtual_network_name = azurerm_virtual_network.vnettest.name
  resource_group_name  = azurerm_resource_group.myextraresourcegroup.name
  address_prefixes     = [var.subnet2_prefix]
  
}

###########################################################

################## Storage ################################
resource "azurerm_storage_account" "hashicatstorageaccount" {
  name                     = "hashicatstorageaccount"
  resource_group_name      = azurerm_resource_group.myresourcegroup.name
  location                 = azurerm_resource_group.myresourcegroup.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    environment = "staging"
  }
}
###########################################################

################## WinVM ##################################
resource "azurerm_network_security_group" "win-sg" {
  name                = "${var.prefix}-winsg"
  location            = var.location
  resource_group_name = azurerm_resource_group.myresourcegroup.name

  security_rule {
    name                       = "HTTP"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "HTTPS"
    priority                   = 102
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "SSH"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

    tags = {
    environment = "Production"
    business_unit = "SANSDemo"
  }

}

resource "azurerm_network_interface" "win-nic" {
  name                      = "${var.prefix}-win-nic"
  location                  = var.location
  resource_group_name       = azurerm_resource_group.myresourcegroup.name

  ip_configuration {
    name                          = "${var.prefix}winipconfig"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.win-pip.id
  }
}

resource "azurerm_network_interface_security_group_association" "win-nic-sg-ass" {
  network_interface_id      = azurerm_network_interface.win-nic.id
  network_security_group_id = azurerm_network_security_group.win-sg.id
}

resource "azurerm_public_ip" "win-pip" {
  name                = "${var.prefix}-winip"
  location            = var.location
  resource_group_name = azurerm_resource_group.myresourcegroup.name
  allocation_method   = "Dynamic"
  domain_name_label   = "${var.prefix}-meow"
}

resource "azurerm_windows_virtual_machine" "win2022" {
  name                = "demo-win2022-1"
  location            = var.location
  resource_group_name = azurerm_resource_group.myresourcegroup.name
  size                = "Standard_B1ms"
  network_interface_ids         = [azurerm_network_interface.win-nic.id]
  admin_username = var.admin_username
  admin_password = var.admin_password


  source_image_reference {
    publisher = var.win_image_publisher
    offer     = var.win_image_offer
    sku       = var.win_image_sku
    version   = var.win_image_version
  }

  os_disk {
    name                  = "${var.prefix}-winosdisk"
    storage_account_type  = "Standard_LRS"
    caching               = "ReadWrite"
  }

  patch_mode          = "AutomaticByPlatform"
    tags = {
    environment = "Production"
    business_unit = "SANSDemo"
  }

  # Added to allow destroy to work correctly.
  depends_on = [azurerm_network_interface_security_group_association.win-nic-sg-ass]
}

################# /Win VM ###################################

resource "azurerm_network_security_group" "catapp-sg" {
  name                = "${var.prefix}-sg"
  location            = var.location
  resource_group_name = azurerm_resource_group.myresourcegroup.name

  security_rule {
    name                       = "HTTP"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "HTTPS"
    priority                   = 102
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "SSH"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "RDP"
    priority                   = 103
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_interface" "catapp-nic" {
  name                      = "${var.prefix}-catapp-nic"
  location                  = var.location
  resource_group_name       = azurerm_resource_group.myresourcegroup.name

  ip_configuration {
    name                          = "${var.prefix}ipconfig"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.catapp-pip.id
  }
}

resource "azurerm_network_interface_security_group_association" "catapp-nic-sg-ass" {
  network_interface_id      = azurerm_network_interface.catapp-nic.id
  network_security_group_id = azurerm_network_security_group.catapp-sg.id
}

resource "azurerm_public_ip" "catapp-pip" {
  name                = "${var.prefix}-ip"
  location            = var.location
  resource_group_name = azurerm_resource_group.myresourcegroup.name
  allocation_method   = "Dynamic"
  domain_name_label   = "${var.prefix}-meowapp"
}

resource "azurerm_virtual_machine" "catapp" {
  name                = "${var.prefix}-meow"
  location            = var.location
  resource_group_name = azurerm_resource_group.myresourcegroup.name
  vm_size             = var.vm_size

  network_interface_ids         = [azurerm_network_interface.catapp-nic.id]
  delete_os_disk_on_termination = "true"

  storage_image_reference {
    publisher = var.image_publisher
    offer     = var.image_offer
    sku       = var.image_sku
    version   = var.image_version
  }

  storage_os_disk {
    name              = "${var.prefix}-osdisk"
    managed_disk_type = "Standard_LRS"
    caching           = "ReadWrite"
    create_option     = "FromImage"
  }

  os_profile {
    computer_name  = var.prefix
    admin_username = var.admin_username
    admin_password = var.admin_password
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

    tags = {
    environment = "Dev"
  }

  # Added to allow destroy to work correctly.
  depends_on = [azurerm_network_interface_security_group_association.catapp-nic-sg-ass]
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
  depends_on = [
    azurerm_virtual_machine.catapp,
  ]

  # Terraform 0.11
  # triggers {
  #   build_number = "${timestamp()}"
  # }

  # Terraform 0.12
  triggers = {
    build_number = timestamp()
  }

  provisioner "file" {
    source      = "files/"
    destination = "/home/${var.admin_username}/"

    connection {
      type     = "ssh"
      user     = var.admin_username
      password = var.admin_password
      host     = azurerm_public_ip.catapp-pip.fqdn
    }
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt -y update",
      "sleep 15",
      "sudo apt -y update",
      "sudo apt -y install apache2",
      "sudo systemctl start apache2",
      "sudo chown -R ${var.admin_username}:${var.admin_username} /var/www/html",
      "chmod +x *.sh",
      "PLACEHOLDER=${var.placeholder} WIDTH=${var.width} HEIGHT=${var.height} PREFIX=${var.prefix} ./deploy_app.sh",
      "sudo apt -y install cowsay",
      "cowsay Mooooooooooo!",
      "cat /var/www/html/index.html",
      "ls -l /var/www/html/index.html"
    ]

    connection {
      type     = "ssh"
      user     = var.admin_username
      password = var.admin_password
      host     = azurerm_public_ip.catapp-pip.fqdn
    }
  }
}

  #@sanssec5x7.onmicrosoft.com

resource "azuread_user" "AMartinez" {
  user_principal_name = "AMartinez@sanssec5x7.onmicrosoft.com"
  display_name        = "A Martinez"
  mail_nickname       = "AMartinez"
  password            = "SecretP@sswd99!"
}

resource "azuread_user" "BSmith" {
  user_principal_name = "BSmith@sanssec5x7.onmicrosoft.com"
  display_name        = "B Smith"
  mail_nickname       = "BSmith"
  password            = "SecretP@sswd99!"
}

resource "azuread_user" "GLee" {
  user_principal_name = "GLee@sanssec5x7.onmicrosoft.com"
  display_name        = "G Lee"
  mail_nickname       = "GLee"
  password            = "SecretP@sswd99!"
}

resource "azuread_user" "KJones" {
  user_principal_name = "KJones@sanssec5x7.onmicrosoft.com"
  display_name        = "K Jones"
  mail_nickname       = "KJones"
  password            = "SecretP@sswd99!"
}

resource "azuread_user" "WAlexander" {
  user_principal_name = "WAlexander@sanssec5x7.onmicrosoft.com"
  display_name        = "W Alexander"
  mail_nickname       = "WAlexander"
  password            = "SecretP@sswd99!"
}

resource "azuread_user" "JAllen" {
  user_principal_name = "JAllen@sanssec5x7.onmicrosoft.com"
  display_name        = "J Allen"
  mail_nickname       = "JAllen"
  password            = "SecretP@sswd99!"
}

#manually provisioned, so we can watch terraform progress
# resource "azuread_user" "readonly" {
#   user_principal_name = "readonly@sanssec5x7.onmicrosoft.com"
#   display_name        = "Read Only"
#   mail_nickname       = "readonly"
#   password            = "SansSecretPassword!"
#   disable_password_expiration = "true"
#   force_password_change       = "false"
# }

# resource "azuread_user" "" {
#   user_principal_name = "@sanssec5x7.onmicrosoft.com"
#   display_name        = ""
#   mail_nickname       = ""
#   password            = "SecretP@sswd99!"
# }