variable "vpc_cider_block" {
  default     = "11.0.0.0/16"
  description = "CIDR Block for the VPC"
  type        = string
}

variable "web_subnet" {
  default     = "11.0.10.0/24"
  description = "Web Subnet"
  type        = string
}

variable "subnet_zone" {

}

variable "main_vpc_name" {

}

# variable "my_public_ip" {

# }

variable "ssh_public_key" {

}
