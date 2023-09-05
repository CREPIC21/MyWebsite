/*

Dcumentation:

1. azurerm_resource_group - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group

2. azurerm_virtual_network - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network

3. azurerm_network_security_group - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group

4. azurerm_subnet_network_security_group_association - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association

*/

# Creating a resource group
resource "azurerm_resource_group" "appgrp" {
  name     = var.resource_group_name
  location = var.location
}

# Creating a virtual network
resource "azurerm_virtual_network" "appnetwork" {
  name                = var.virtual_network_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = [var.virtual_network_address_space]

  subnet {
    name           = var.subnet_name
    address_prefix = var.subnet_address_prefix
  }
  depends_on = [
    azurerm_resource_group.appgrp
  ]
}

# Creating a security group
resource "azurerm_network_security_group" "appsecuritygroup" {
  name                = var.network_security_group_name
  resource_group_name = var.resource_group_name
  location            = var.location

  security_rule {
    name                       = "AllowSSHandHTTP"
    priority                   = 300
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_ranges    = ["22", "80"] # port for SSH connection and Web access for Linux VM
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  depends_on = [
    azurerm_resource_group.appgrp
  ]
}

# Associating subnet with security group created above
resource "azurerm_subnet_network_security_group_association" "appsecuritygroupassociation" {
  subnet_id                 = azurerm_virtual_network.appnetwork.subnet.*.id[0]
  network_security_group_id = azurerm_network_security_group.appsecuritygroup.id
}
