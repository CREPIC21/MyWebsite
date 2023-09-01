/*

Dcumentation:

1. azurerm_availability_set - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/availability_set

*/

# Creating a avaliability set
resource "azurerm_availability_set" "appset" {
  name                         = "app-set"
  location                     = azurerm_resource_group.appgrp.location
  resource_group_name          = azurerm_resource_group.appgrp.name
  platform_fault_domain_count  = 3
  platform_update_domain_count = 3
  depends_on = [
    azurerm_resource_group.appgrp
  ]
}
