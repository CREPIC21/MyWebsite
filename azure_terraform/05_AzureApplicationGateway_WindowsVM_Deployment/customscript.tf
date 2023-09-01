/*

Dcumentation:

1. azurerm_storage_account - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account.html

2. azurerm_storage_container - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container

3. azurerm_storage_blob - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_blob

4. azurerm_virtual_machine_extension - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_machine_extension

*/

# Creating an storage account where we will upload custom script
resource "azurerm_storage_account" "appgrpstorage" {
  name                     = "appstg456243"
  resource_group_name      = local.resource_group_name
  location                 = local.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"
  depends_on = [
    azurerm_resource_group.appgrp
  ]
}

# Creating a container in storage account where we will upload custom script
resource "azurerm_storage_container" "deployment_files" {
  name                  = "deployment-files"
  storage_account_name  = azurerm_storage_account.appgrpstorage.name
  container_access_type = "blob"
  depends_on = [
    azurerm_storage_account.appgrpstorage
  ]
}

# Creating a blob in a container where we will upload custom script
resource "azurerm_storage_blob" "files" {
  for_each = {
    "IIS_Config_images.ps1" = "C:\\Users\\crepi\\Desktop\\Piwik Laptop\\projects\\myPortfolio\\azure_terraform\\05_AzureApplicationGateway_WindowsVM_Deployment\\IIS_Config_images.ps1"
    "IIS_Config_videos.ps1" = "C:\\Users\\crepi\\Desktop\\Piwik Laptop\\projects\\myPortfolio\\azure_terraform\\05_AzureApplicationGateway_WindowsVM_Deployment\\IIS_Config_videos.ps1"
    "images_01"             = "C:\\Users\\crepi\\Desktop\\Piwik Laptop\\projects\\myPortfolio\\azure_terraform\\05_AzureApplicationGateway_WindowsVM_Deployment\\image01.jpg"
    "images_02"             = "C:\\Users\\crepi\\Desktop\\Piwik Laptop\\projects\\myPortfolio\\azure_terraform\\05_AzureApplicationGateway_WindowsVM_Deployment\\image02.jpg"
    "videos_01"             = "C:\\Users\\crepi\\Desktop\\Piwik Laptop\\projects\\myPortfolio\\azure_terraform\\05_AzureApplicationGateway_WindowsVM_Deployment\\video01.MOV"
    "videos_02"             = "C:\\Users\\crepi\\Desktop\\Piwik Laptop\\projects\\myPortfolio\\azure_terraform\\05_AzureApplicationGateway_WindowsVM_Deployment\\video02.MOV"
  }
  name                   = each.key
  storage_account_name   = azurerm_storage_account.appgrpstorage.name
  storage_container_name = azurerm_storage_container.deployment_files.name
  type                   = "Block"
  source                 = each.value
  depends_on = [
    azurerm_storage_container.deployment_files
  ]
}

resource "azurerm_virtual_machine_extension" "vmextention" {
  for_each             = toset(local.function)
  name                 = "${each.key}-vmextention"
  virtual_machine_id   = azurerm_windows_virtual_machine.vm[each.key].id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.10"

  settings = <<SETTINGS
    {
      "fileUris": [
      "https://${azurerm_storage_account.appgrpstorage.name}.blob.core.windows.net/deployment-files/IIS_Config_images.ps1", 
      "https://${azurerm_storage_account.appgrpstorage.name}.blob.core.windows.net/deployment-files/IIS_Config_videos.ps1", 
      "https://${azurerm_storage_account.appgrpstorage.name}.blob.core.windows.net/deployment-files/images_01", 
      "https://${azurerm_storage_account.appgrpstorage.name}.blob.core.windows.net/deployment-files/images_02", 
      "https://${azurerm_storage_account.appgrpstorage.name}.blob.core.windows.net/deployment-files/videos_01", 
      "https://${azurerm_storage_account.appgrpstorage.name}.blob.core.windows.net/deployment-files/videos_02"
      ],
          "commandToExecute": "powershell -ExecutionPolicy Unrestricted -file IIS_Config_${each.key}.ps1"   
    }
SETTINGS
}


