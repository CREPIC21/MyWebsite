/*

Dcumentation:

1. azurerm_public_ip - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip

2. azurerm_lb - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb

3. azurerm_lb_backend_address_pool - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_backend_address_pool

4. azurerm_lb_backend_address_pool_address - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_backend_address_pool_address

5. azurerm_lb_probe - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_probe

6. azurerm_lb_rule - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/lb_rule

*/

# Creating a public IP 
resource "azurerm_public_ip" "loabip" {
  name                = "load-ip"
  resource_group_name = azurerm_resource_group.appgrp.name
  location            = azurerm_resource_group.appgrp.location
  allocation_method   = "Static"
  sku                 = "Standard"
  depends_on = [
    azurerm_resource_group.appgrp
  ]
}

resource "azurerm_lb" "appbalancer" {
  name                = "appbalancer"
  location            = local.location
  resource_group_name = local.resource_group_name
  sku                 = "Standard"
  sku_tier            = "Regional"

  frontend_ip_configuration {
    name                 = "frontend-ip"
    public_ip_address_id = azurerm_public_ip.loabip.id
  }
  depends_on = [azurerm_public_ip.loabip]
}

resource "azurerm_lb_backend_address_pool" "poolA" {
  loadbalancer_id = azurerm_lb.appbalancer.id
  name            = "PoolA"
  depends_on      = [azurerm_lb.appbalancer]
}

resource "azurerm_lb_backend_address_pool_address" "appvmaddress" {
  count                   = var.number_of_machines
  name                    = "appvm${count.index}"
  backend_address_pool_id = azurerm_lb_backend_address_pool.poolA.id
  virtual_network_id      = azurerm_virtual_network.appnetwork.id
  ip_address              = azurerm_network_interface.appinterface[count.index].private_ip_address
  depends_on = [
    azurerm_lb_backend_address_pool.poolA,
    azurerm_network_interface.appinterface
  ]

}

resource "azurerm_lb_probe" "probeA" {
  loadbalancer_id = azurerm_lb.appbalancer.id
  name            = "ProbeA"
  port            = 80
  protocol        = "Tcp"
  depends_on      = [azurerm_lb.appbalancer]
}

resource "azurerm_lb_rule" "RuleA" {
  loadbalancer_id                = azurerm_lb.appbalancer.id
  name                           = "RuleA"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = "frontend-ip"
  probe_id                       = azurerm_lb_probe.probeA.id
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.poolA.id]
  depends_on                     = [azurerm_lb.appbalancer]
}
