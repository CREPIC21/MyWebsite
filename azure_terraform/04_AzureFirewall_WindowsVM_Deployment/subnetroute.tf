/*

Documentation:

1. azurerm_route_table - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/route_table

2. azurerm_route - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/route

3. azurerm_subnet_route_table_association - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_route_table_association

*/

resource "azurerm_route_table" "firewallroutetable" {
  name                          = "firewall-route-table"
  location                      = local.location
  resource_group_name           = local.resource_group_name
  disable_bgp_route_propagation = true
  depends_on = [
    azurerm_resource_group.appgrp
  ]
}

resource "azurerm_route" "firewallroute" {
  name                   = "acceptanceTestRoute1"
  resource_group_name    = local.resource_group_name
  route_table_name       = azurerm_route_table.firewallroutetable.name
  address_prefix         = "0.0.0.0/0"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = azurerm_firewall.appfirewall.ip_configuration[0].private_ip_address

  depends_on = [
    azurerm_route_table.firewallroutetable
  ]
}

resource "azurerm_subnet_route_table_association" "subnetassociation" {
  subnet_id      = azurerm_subnet.subnetA.id
  route_table_id = azurerm_route_table.firewallroutetable.id
}
