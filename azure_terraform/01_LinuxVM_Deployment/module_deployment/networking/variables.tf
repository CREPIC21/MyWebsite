variable "resource_group_name" {
  type        = string
  description = "Defines the resource group name"
}

variable "location" {
  type        = string
  description = "Defines the location"
}

variable "virtual_network_name" {
  type        = string
  description = "Defines the virtual network name"
}

variable "virtual_network_address_space" {
  type        = string
  description = "Defines the virtual network address space"
}

variable "subnet_name" {
  type        = string
  description = "Defines the subnet name"
}

variable "subnet_address_prefix" {
  type        = string
  description = "Defines the subnet name"
}

variable "network_security_group_name" {
  type        = string
  description = "Defines network security group name"
}
