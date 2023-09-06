variable "resource_group_name" {
  type        = string
  description = "Defines the resource group name"
}

variable "location" {
  type        = string
  description = "Defines the location"
}

variable "service_plan_name" {
  type        = string
  description = "Defines the service plan name"
}

variable "webapp_name" {
  type        = string
  description = "Defines the web app name"
}

variable "webapp_docker_image" {
  type        = string
  description = "Defines the web app docker image"
}

variable "webapp_docker_image_tag" {
  type        = string
  description = "Defines the web app docker image tag"
}

variable "webapp_docker_image_tag_staging" {
  type        = string
  description = "Defines the web app docker image tag for staging"
}

variable "webappplan_os_type" {
  type        = string
  description = "Defines the web app OS type"
}

variable "webappplan_sku_name" {
  type        = string
  description = "Defines the web app SKU name"
}

variable "web_app_slot_name" {
  type        = string
  description = "Defines the web app slot name name"
}
