# Creating a network interface
resource "azurerm_network_interface" "appinterface" {
  count               = var.number_of_machines
  name                = "app-nic-${count.index}"
  location            = azurerm_resource_group.appgrp.location
  resource_group_name = azurerm_resource_group.appgrp.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnetA.id
    private_ip_address_allocation = "Dynamic"
  }
  depends_on = [
    azurerm_virtual_network.appnetwork
  ]
}

# Create Windows VM
resource "azurerm_windows_virtual_machine" "appvm" {
  count               = var.number_of_machines
  name                = "appvm-${count.index}"
  resource_group_name = azurerm_resource_group.appgrp.name
  location            = azurerm_resource_group.appgrp.location
  size                = "Standard_Ds1_v2"
  admin_username      = "adminuser"
  admin_password      = "Test12345%$#@!"
  availability_set_id = azurerm_availability_set.appset.id
  network_interface_ids = [
    azurerm_network_interface.appinterface[count.index].id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
  depends_on = [
    azurerm_network_interface.appinterface,
    azurerm_availability_set.appset,
    azurerm_virtual_network.appnetwork
  ]
}