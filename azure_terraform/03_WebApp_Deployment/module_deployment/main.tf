module "web_app_module" {
  source                          = "./webapp"
  resource_group_name             = "web-app-gr"
  location                        = "North Europe"
  service_plan_name               = "web-app-plan"
  webappplan_os_type              = "Linux"
  webappplan_sku_name             = "S1"
  webapp_name                     = "webappportdanman"
  webapp_docker_image             = "crepic21/my-website"
  webapp_docker_image_tag         = "148"
  web_app_slot_name               = "staging"
  webapp_docker_image_tag_staging = "131"
}


