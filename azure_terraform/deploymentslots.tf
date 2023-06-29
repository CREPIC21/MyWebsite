# Creating additional Windows Web App Slot
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