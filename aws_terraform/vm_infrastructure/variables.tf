variable "deployment_region" {
  type        = string
  description = "AWS Deployment Region"
  default     = "eu-central-1"
}

variable "vpc_cider_block" {
  type        = string
  description = "CIDR Block for the VPC"
  default     = "11.0.0.0/16"
}

variable "web_subnet" {
  type        = string
  description = "Web Subnet"
  default     = "11.0.10.0/24"
}

variable "main_vpc_default_rt_cidr_block" {
  type        = string
  description = "CIDR Block for the Internet Gateway and non-local traffic"
  default     = "0.0.0.0/0"
}

variable "subnet_zone" {
  type        = string
  description = "Subnet Zone"
  default     = "eu-central-1a"
}

variable "main_vpc_name" {
  type        = string
  description = "Main VPC Name"
  default     = "Production VPC"
}

#  variable "my_public_ip" {
#   type        = string
#   description = "My Machine (laptop, PC) Public IP"
#   default     = "127.0.0.1"
#    }

variable "ingress_ports" {
  description = "List Of Ingress Ports"
  type        = list(number)
  default     = [22, 80]
}

variable "ssh_public_key" {
  type = string
}

variable "test_ssh_key_name" {
  type        = string
  description = "SSH Key Name"
  default     = "testing_ssh_key"
}

variable "vm_instance_type" {
  type        = string
  description = "VM Instance Type"
  default     = "t2.micro"
}

variable "my_vm_name" {
  type        = string
  description = "EC2 Instance Name"
  default     = "My Portfolio EC2 Instance - Amazon Linux 2"
}