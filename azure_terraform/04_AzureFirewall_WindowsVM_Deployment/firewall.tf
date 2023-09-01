/*

Dcumentation:

1. azurerm_public_ip - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip

2. azurerm_subnet - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet

3. azurerm_firewall_policy - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/firewall_policy

4. azurerm_firewall - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/firewall

*/

# First we need to create a Public IP address for the Azure Firewall
resource "azurerm_public_ip" "firewallip" {
  name                = "firewall-ip"
  resource_group_name = local.resource_group_name
  location            = local.location
  allocation_method   = "Static"
  sku                 = "Standard"
  sku_tier            = "Regional"
  depends_on = [
    azurerm_resource_group.appgrp
  ]

}

# We need an additional subnet in the virtual network
resource "azurerm_subnet" "firewallsubnet" {
  name                 = "AzureFirewallSubnet"
  resource_group_name  = local.resource_group_name
  virtual_network_name = local.virtual_network.name
  address_prefixes     = ["10.0.1.0/24"]
  depends_on = [
    azurerm_virtual_network.appnetwork
  ]
}

resource "azurerm_firewall_policy" "firewallpolicy" {
  name                = "firewallpolicy"
  resource_group_name = local.resource_group_name
  location            = local.location
  depends_on          = [azurerm_resource_group.appgrp]
}

resource "azurerm_firewall" "appfirewall" {
  name                = "appfirewall"
  location            = local.location
  resource_group_name = local.resource_group_name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.firewallsubnet.id
    public_ip_address_id = azurerm_public_ip.firewallip.id
  }

  sku_tier = "Standard"
  sku_name = "AZFW_VNet"

  firewall_policy_id = azurerm_firewall_policy.firewallpolicy.id
  depends_on = [
    azurerm_firewall_policy.firewallpolicy
  ]
}
