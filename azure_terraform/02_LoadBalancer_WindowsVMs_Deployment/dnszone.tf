resource "azurerm_dns_zone" "cloudportalhub" {
  name                = "projectdanijel.xyz" // need to include domain name from namecheap, godaddy ...
  resource_group_name = local.resource_group_name
}

// add server names to nameservers on namecheap, godaddy ...
output "server-names" {
  value = azurerm_dns_zone.cloudportalhub.name_servers
}

// creating an A record for domain name IP mapping from our load balancer
resource "azurerm_dns_a_record" "example" {
  name                = "www"
  zone_name           = azurerm_dns_zone.cloudportalhub.name
  resource_group_name = local.resource_group_name
  ttl                 = 300
  records             = [azurerm_public_ip.loabip.ip_address]
}