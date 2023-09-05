variable "apppublicip_name" {
  type    = string
  default = "myportfolio-public-IP"
}

variable "ip_configuration_name" {
  type    = string
  default = "myportfolio-ip-configuration"
}

variable "private_ip_address_allocation" {
  type    = string
  default = "Dynamic"
}

variable "apppublicip_allocation_method" {
  type    = string
  default = "Static"
}

variable "appvm_name" {
  type    = string
  default = "myportfolio-VM"
}

variable "appvm_size" {
  type    = string
  default = "Standard_DS1_v2"
}

variable "appvm_admin_username" {
  type    = string
  default = "adminuser"
}

variable "vm_os_disk_caching" {
  type    = string
  default = "ReadWrite"
}

variable "vm_os_disk_storage_account_type" {
  type    = string
  default = "Standard_LRS"
}

variable "linuxkey_algorithm" {
  type    = string
  default = "RSA"
}

variable "linuxkey_rsa_bits" {
  type    = number
  default = 4096
}

variable "linuxpemkey_filename" {
  type    = string
  default = "linuxkey.pem"
}

variable "appinterface_name" {
  type    = string
  default = "portfolio-nic"
}
