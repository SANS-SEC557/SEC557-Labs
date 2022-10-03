##############################################################################
# Variables File
# 
# Here is where we store the default values for all the variables used in our
# Terraform code. If you create a variable with no default, the user will be
# prompted to enter it (or define it via config file or command line flags.)

variable "prefix" {
  description = "This prefix will be included in the name of most resources."
  default = "sansdemos-hashicat"
}

variable "location" {
  description = "The region where the virtual network is created."
  default     = "centralus"
}

variable "extralocation" {
  description = "The region where the virtual network is created."
  default     = "westeurope"
}

variable "address_space" {
  description = "The address space that is used by the virtual network. You can supply more than one address space. Changing this forces a new resource to be created."
  default     = "10.55.0.0/16"
}

variable "subnet_prefix" {
  description = "The address prefix to use for the subnet."
  default     = "10.55.7.0/24"
}

variable "address_space2" {
  description = "The address space that is used by the virtual network. You can supply more than one address space. Changing this forces a new resource to be created."
  default     = "10.50.0.0/16"
}

variable "subnet2_prefix" {
  description = "The address prefix to use for the subnet."
  default     = "10.50.7.0/24"
}

variable "vm_size" {
  description = "Specifies the size of the virtual machine."
  default     = "Standard_B1s"
}

variable "image_publisher" {
  description = "Name of the publisher of the image (az vm image list)"
  default     = "Canonical"
}

variable "image_offer" {
  description = "Name of the offer (az vm image list)"
  default     = "0001-com-ubuntu-minimal-jammy"
}

variable "image_sku" {
  description = "Image SKU to apply (az vm image list)"
  default     = "minimal-22_04-lts"
}

variable "image_version" {
  description = "Version of the image to apply (az vm image list)"
  default     = "latest"
}


variable "win_image_publisher" {
  description = "Name of the publisher of the image (az vm image list)"
  default     = "MicrosoftWindowsServer"
}

variable "win_image_offer" {
  description = "Name of the offer (az vm image list)"
  default     = "WindowsServer"
}

variable "win_image_sku" {
  description = "Image SKU to apply (az vm image list)"
  default     = "2022-datacenter-azure-edition-core"
}

variable "win_image_version" {
  description = "Version of the image to apply (az vm image list)"
  default     = "latest"
}

variable "admin_username" {
  description = "Administrator user name for linux and mysql"
  default     = "sansdemo"
}

variable "admin_password" {
  description = "Administrator password for linux and mysql"
  default     = "SansSecretPassword!"
}

variable "height" {
  default     = "400"
  description = "Image height in pixels."
}

variable "width" {
  default     = "600"
  description = "Image width in pixels."
}

variable "placeholder" {
  default     = "placekitten.com"
  description = "Image-as-a-service URL. Some other fun ones to try are fillmurray.com, placecage.com, placebeard.it, loremflickr.com, baconmockup.com, placeimg.com, placebear.com, placeskull.com, stevensegallery.com, placedog.net"
}
