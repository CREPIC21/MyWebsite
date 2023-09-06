variable "resource_group_name" {
  type    = string
  default = "myportfolio-grp"
}

variable "location" {
  type    = string
  default = "North Europe"
}

variable "service_plan_name" {
  type    = string
  default = "myportfolio-service-plan"
}

variable "webapp_name" {
  type    = string
  default = "myportfolio-webapp"
}

variable "webapp_docker_image" {
  type    = string
  default = "crepic21/my-website"
}

variable "webapp_docker_image_tag" {
  type    = string
  default = "148"
}

variable "webapp_docker_image_tag_staging" {
  type    = string
  default = "131"
}

variable "webappplan_os_type" {
  type    = string
  default = "Linux"
}

variable "webappplan_sku_name" {
  type    = string
  default = "S1"
}

variable "web_app_slot_name" {
  type    = string
  default = "staging"
}
