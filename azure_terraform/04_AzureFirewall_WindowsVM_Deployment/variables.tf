variable "number_of_subnets" {
  type        = number
  description = "Define the number of subnets"
  default     = 3
  validation {
    condition     = var.number_of_subnets < 5
    error_message = "The number of subnets must be less then 5."
  }
}

variable "number_of_machines" {
  type        = number
  description = "Define the number of machines"
  default     = 3
}

variable "scfile" {
  type    = string
  default = "IIS_Config.ps1"
}