# Creating a virtual network
resource "azurerm_virtual_network" "appnetwork" {
  name                = local.virtual_network.name
  location            = azurerm_resource_group.appgrp.location
  resource_group_name = azurerm_resource_group.appgrp.name
  address_space       = [local.virtual_network.address_space]
  depends_on = [
    azurerm_resource_group.appgrp
  ]
}

# Another way of creating subnets - not in virtual network resource directly
resource "azurerm_subnet" "subnetA" {
  name                 = "SubnetA"
  resource_group_name  = local.resource_group_name
  virtual_network_name = local.virtual_network.name
  address_prefixes     = ["10.0.0.0/24"]
  depends_on = [
    azurerm_virtual_network.appnetwork
  ]
}

# Creating a security group
resource "azurerm_network_security_group" "appsecuritygroup" {
  name                = "appsecuritygroup"
  resource_group_name = azurerm_resource_group.appgrp.name
  location            = azurerm_resource_group.appgrp.location

  security_rule {
    name                       = "AllowRDP"
    priority                   = 300
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389" # port for RDP connection for Windows VM
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "AllowHTTP"
    priority                   = 400
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80" # port for web server
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  depends_on = [
    azurerm_resource_group.appgrp
  ]
}

# Associating subnet with security group created above
resource "azurerm_subnet_network_security_group_association" "appsecuritygroupassociation" {
  subnet_id                 = azurerm_subnet.subnetA.id
  network_security_group_id = azurerm_network_security_group.appsecuritygroup.id
  depends_on = [
    azurerm_virtual_network.appnetwork,
    azurerm_network_security_group.appsecuritygroup
  ]
}