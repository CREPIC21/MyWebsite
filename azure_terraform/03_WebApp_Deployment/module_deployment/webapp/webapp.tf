/*

Dcumentation:

1. azurerm_resource_group - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group

2. azurerm_service_plan - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/service_plan

3. azurerm_linux_web_app - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_web_app

4. azurerm_linux_web_app_slot - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_web_app_slot

5. azurerm_web_app_active_slot - https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/web_app_active_slot

*/

# Creating a resource group
resource "azurerm_resource_group" "appgrp" {
  name     = var.resource_group_name
  location = var.location
}

# Creating App Service Plan
resource "azurerm_service_plan" "webappplan" {
  name                = var.service_plan_name
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type             = var.webappplan_os_type
  sku_name            = var.webappplan_sku_name
  depends_on          = [azurerm_resource_group.appgrp]
}

# Creating Web App
resource "azurerm_linux_web_app" "myportfolio_01" {
  name                = var.webapp_name
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = azurerm_service_plan.webappplan.id

  site_config {
    application_stack {
      docker_image     = var.webapp_docker_image
      docker_image_tag = var.webapp_docker_image_tag
    }
  }
  depends_on = [
    azurerm_service_plan.webappplan
  ]
}

# Creating additional Linux Web App Slot
resource "azurerm_linux_web_app_slot" "web_app_slot" {
  name           = var.web_app_slot_name
  app_service_id = azurerm_linux_web_app.myportfolio_01.id

  site_config {
    application_stack {
      docker_image     = var.webapp_docker_image
      docker_image_tag = var.webapp_docker_image_tag_staging
    }
  }

  depends_on = [azurerm_service_plan.webappplan]
}

# Configuring staging slot as active slot
resource "azurerm_web_app_active_slot" "active_slot" {
  slot_id = azurerm_linux_web_app_slot.web_app_slot.id
}
