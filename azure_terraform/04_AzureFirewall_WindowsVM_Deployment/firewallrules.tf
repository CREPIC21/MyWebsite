/*

Documentation:


1. azurerm_firewall_policy_rule_collection_group - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/firewall_policy_rule_collection_group

*/


resource "azurerm_firewall_policy_rule_collection_group" "rulecollection" {
  name               = "rulecollection"
  firewall_policy_id = azurerm_firewall_policy.firewallpolicy.id
  priority           = 500

  nat_rule_collection {
    name     = "nat_rule_collection1"
    priority = 300
    action   = "Dnat"
    rule {
      name                = "AllowRDP"
      protocols           = ["TCP"]
      source_addresses    = ["0.0.0.0/0"]
      destination_address = azurerm_public_ip.firewallip.ip_address
      destination_ports   = ["4000"]
      translated_address  = azurerm_network_interface.appinterface.private_ip_address
      translated_port     = "3389"
    }
    rule {
      name                = "AllowHTTP"
      protocols           = ["TCP"]
      source_addresses    = ["0.0.0.0/0"]
      destination_address = azurerm_public_ip.firewallip.ip_address
      destination_ports   = ["5000"]
      translated_address  = azurerm_network_interface.appinterface.private_ip_address
      translated_port     = "80"
    }
  }

  application_rule_collection {
    name     = "app_rule_collection1"
    priority = 500
    action   = "Allow"
    rule {
      name = "AllowMicrosoft"
      protocols {
        type = "Http"
        port = 80
      }
      protocols {
        type = "Https"
        port = 443
      }
      source_addresses  = [azurerm_network_interface.appinterface.private_ip_address]
      destination_fqdns = ["*.microsoft.com"]
    }
  }
}
