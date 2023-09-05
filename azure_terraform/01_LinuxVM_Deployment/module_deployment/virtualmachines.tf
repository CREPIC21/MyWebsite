/*

Dcumentation:

1. azurerm_network_interface - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface

2. azurerm_public_ip - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip

3. tls_private_key - https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key

4. local_file - https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file

5. template_file - https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file

6. azurerm_linux_virtual_machine - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine

*/

# Creating a network interface
resource "azurerm_network_interface" "appinterface" {
  name                = var.appinterface_name
  location            = module.networking_module.location
  resource_group_name = module.networking_module.resource_group_name

  ip_configuration {
    name      = var.ip_configuration_name
    subnet_id = module.networking_module.subnetid
    ### another way to get the specific subnet id - we need to convert returned set to a list, then we can use index
    # subnet_id                     = tolist(azurerm_virtual_network.appnetwork.subnet[0].id) 
    private_ip_address_allocation = var.private_ip_address_allocation
    public_ip_address_id          = azurerm_public_ip.apppublicip.id # assigning public IP to network interface from the "azurerm_public_ip" resource created below
  }
  depends_on = [
    // dependency also relies on outputs from the child modul as those dependencies are created in child module -> ./networking/outputs.tf
    module.networking_module.subnet
  ]
}

# Creating a public IP 
resource "azurerm_public_ip" "apppublicip" {
  name                = var.apppublicip_name
  resource_group_name = module.networking_module.resource_group_name
  location            = module.networking_module.location
  allocation_method   = var.apppublicip_allocation_method
  depends_on = [
    // dependency also relies on outputs from the child module as those dependencies are created in child module -> ./networking/outputs.tf
    module.networking_module.resource_group
  ]
}

# Creating RSA private key of size 4096 bits - only for development purposes, in real life scenario create your own private/public key-pair
resource "tls_private_key" "linuxkey" {
  algorithm = var.linuxkey_algorithm
  rsa_bits  = var.linuxkey_rsa_bits
}

# Getting the context of private key created in previous step and saving it to a local file
resource "local_file" "linuxpemkey" {
  filename = var.linuxpemkey_filename
  content  = tls_private_key.linuxkey.private_key_pem
  depends_on = [
    tls_private_key.linuxkey
  ]
}

# Deployiong MyPortfolio script to VM using CloudInit and custom_data attribute in azurerm_linux_virtual_machine resource
data "template_file" "cloudinitdata" {
  template = file("../cloudinitDeployment.sh")
}

# Create Linux VM
resource "azurerm_linux_virtual_machine" "appvm" {
  name                = var.appvm_name
  resource_group_name = module.networking_module.resource_group_name
  location            = module.networking_module.location
  size                = var.appvm_size
  admin_username      = var.appvm_admin_username
  custom_data         = base64encode(data.template_file.cloudinitdata.rendered)
  # admin_password                  = "Azure@123"
  # disable_password_authentication = false
  admin_ssh_key {
    username   = var.appvm_admin_username
    public_key = tls_private_key.linuxkey.public_key_openssh
  }
  network_interface_ids = [
    azurerm_network_interface.appinterface.id,
  ]

  os_disk {
    caching              = var.vm_os_disk_caching
    storage_account_type = var.vm_os_disk_storage_account_type
  }

  source_image_reference {
    publisher = "canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts-gen2"
    version   = "latest"
  }
  depends_on = [
    // dependency also relies on outputs from the child module as those dependencies are created in child module -> ./networking/outputs.tf
    module.networking_module.resource_group,
    azurerm_network_interface.appinterface,
    tls_private_key.linuxkey
  ]
}

output "app-public-IP" {
  value = azurerm_public_ip.apppublicip.ip_address
}
