# Creating a resource group
resource "azurerm_resource_group" "appgrp" {
  name     = var.resource_group_name
  location = var.location
}

# Creating a virtual network
resource "azurerm_virtual_network" "appnetwork" {
  name                = var.virtual_network.name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = [var.virtual_network.address_space]

  subnet {
    name           = var.subnets_info_list[0].subnetA_name
    address_prefix = var.subnets_info_list[0].subnetA_address_prefix
  }
  depends_on = [
    azurerm_resource_group.appgrp
  ]
}

# Creating a network interface
resource "azurerm_network_interface" "appinterface" {
  name                = var.appinterface_name
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name      = var.ip_configuration_name
    subnet_id = azurerm_virtual_network.appnetwork.subnet.*.id[0]
    ### another way to get the specific subnet id - we need to convert returned set to a list, then we can use index
    # subnet_id                     = tolist(azurerm_virtual_network.appnetwork.subnet[0].id) 
    private_ip_address_allocation = var.private_ip_address_allocation
    public_ip_address_id          = azurerm_public_ip.apppublicip.id # assigning public IP to network interface from the "azurerm_public_ip" resource created below
  }
  depends_on = [
    azurerm_virtual_network.appnetwork
  ]
}

# Creating a public IP 
resource "azurerm_public_ip" "apppublicip" {
  name                = var.apppublicip_name
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = var.apppublicip_allocation_method
  depends_on = [
    azurerm_resource_group.appgrp
  ]
}

# Creating a security group
resource "azurerm_network_security_group" "appsecuritygroup" {
  name                = var.appsecuritygroup_name
  resource_group_name = azurerm_resource_group.appgrp.name
  location            = azurerm_resource_group.appgrp.location

  security_rule {
    name                       = "AllowSSH"
    priority                   = 300
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_ranges    = ["22", "80"] # port for SSH connection and Web access for Linux VM
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  depends_on = [
    azurerm_resource_group.appgrp
  ]
}

# Associating subnet with security group created above
resource "azurerm_subnet_network_security_group_association" "appsecuritygroupassociation" {
  subnet_id                 = azurerm_virtual_network.appnetwork.subnet.*.id[0]
  network_security_group_id = azurerm_network_security_group.appsecuritygroup.id
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

# Create Linux VM
resource "azurerm_linux_virtual_machine" "appvm" {
  name                = var.appvm_name
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = var.appvm_size
  admin_username      = var.appvm_admin_username
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
    azurerm_resource_group.appgrp,
    azurerm_network_interface.appinterface,
    tls_private_key.linuxkey
  ]
}

# Creating additional disk that will be attached to VM
resource "azurerm_managed_disk" "appdisk" {
  name                 = var.appdisk_name
  location             = var.location
  resource_group_name  = var.resource_group_name
  storage_account_type = var.vm_os_disk_storage_account_type
  create_option        = var.appdisk_create_option
  disk_size_gb         = var.appdisk_disk_size_gb
  depends_on = [
    azurerm_resource_group.appgrp
  ]
}

# Attaching the disk created in previous step to VM
## see video on how to initialize the disk once the resource is created - https://www.udemy.com/course/terraform-on-azure-services/learn/lecture/32749324#questions/18296260
resource "azurerm_virtual_machine_data_disk_attachment" "diskattach" {
  managed_disk_id    = azurerm_managed_disk.appdisk.id
  virtual_machine_id = azurerm_linux_virtual_machine.appvm.id
  lun                = var.diskattach_lun
  caching            = var.diskattach_caching
  depends_on = [
    azurerm_managed_disk.appdisk,
    azurerm_linux_virtual_machine.appvm
  ]
}

# Deployiong MyPortfolio script to VM
resource "azurerm_virtual_machine_extension" "deployment_script_extension" {
  name                 = var.deployment_script_extension_name
  virtual_machine_id   = azurerm_linux_virtual_machine.appvm.id
  publisher            = "Microsoft.Azure.Extensions"
  type                 = "CustomScript"
  type_handler_version = "2.0"

  // https://hypernephelist.com/2019/06/25/azure-vm-custom-script-extensions-with-terraform.html
  settings = <<SETTINGS
 {
    "script": "${filebase64("deploymentScript.sh")}"
}
SETTINGS

  depends_on = [
    azurerm_linux_virtual_machine.appvm
  ]
}

# Declaring output variables
# output "subnetA-id" {
#   value = azurerm_virtual_network.appnetwork.subnet.*.id[0]
# }

output "app-public-IP" {
  value = azurerm_public_ip.apppublicip.ip_address
}

