/*

Dcumentation:

1. azurerm_virtual_network - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network

2. azurerm_network_security_group - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group

3. azurerm_subnet_network_security_group_association - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association

*/

# Creating a virtual network
resource "azurerm_virtual_network" "appnetwork" {
  name                = var.virtual_network.name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = [var.virtual_network.address_space]

  subnet {
    name           = var.subnets_info_list[0].subnetA_name
    address_prefix = var.subnets_info_list[0].subnetA_address_prefix
  }
  depends_on = [
    azurerm_resource_group.appgrp
  ]
}

# Creating a security group
resource "azurerm_network_security_group" "appsecuritygroup" {
  name                = var.appsecuritygroup_name
  resource_group_name = azurerm_resource_group.appgrp.name
  location            = azurerm_resource_group.appgrp.location

  dynamic "security_rule" {
    for_each = var.networksecuritygroup_rules
    content {
      name                       = "Allow-${security_rule.value.destination_port_range}"
      priority                   = security_rule.value.priority
      direction                  = "Inbound"
      access                     = "Allow"
      protocol                   = "Tcp"
      source_port_range          = "*"
      destination_port_range     = security_rule.value.destination_port_range
      source_address_prefix      = "*"
      destination_address_prefix = "*"
    }
  }

  # security_rule {
  #   name                       = "AllowSSHandHTTP"
  #   priority                   = 300
  #   direction                  = "Inbound"
  #   access                     = "Allow"
  #   protocol                   = "Tcp"
  #   source_port_range          = "*"
  #   destination_port_ranges    = ["22", "80"] # port for SSH connection and Web access for Linux VM
  #   source_address_prefix      = "*"
  #   destination_address_prefix = "*"
  # }

  depends_on = [
    azurerm_resource_group.appgrp
  ]
}

# Associating subnet with security group created above
resource "azurerm_subnet_network_security_group_association" "appsecuritygroupassociation" {
  subnet_id                 = azurerm_virtual_network.appnetwork.subnet.*.id[0]
  network_security_group_id = azurerm_network_security_group.appsecuritygroup.id
}

# Declaring output variables
# output "subnetA-id" {
#   value = azurerm_virtual_network.appnetwork.subnet.*.id[0]
# }
