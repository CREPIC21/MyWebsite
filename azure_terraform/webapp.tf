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
