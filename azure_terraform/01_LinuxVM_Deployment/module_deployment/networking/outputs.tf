output "resource_group_name" {
  value = azurerm_resource_group.appgrp.name
}

output "location" {
  value = azurerm_virtual_network.appnetwork.location
}

output "subnetid" {
  value = azurerm_virtual_network.appnetwork.subnet.*.id[0]
}

output "subnet" {
  value = azurerm_virtual_network.appnetwork.subnet
}

output "resource_group" {
  value = azurerm_resource_group.appgrp
}
