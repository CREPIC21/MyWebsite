module "networking_module" {
  source                        = "./networking"
  resource_group_name           = "myportfolio-grp"
  location                      = "North Europe"
  virtual_network_name          = "app-network"
  virtual_network_address_space = "10.0.0.0/16"
  subnet_name                   = "SubnetA"
  subnet_address_prefix         = "10.0.0.0/24"
  network_security_group_name   = "app-nsg"
}


