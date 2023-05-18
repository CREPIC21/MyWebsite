variable "deployment_region" {
  type        = string
  description = "AWS Deployment Region"
  default     = "eu-central-1"
}

variable "cluster_name" {
  type        = string
  description = "Cluster name"
  default     = "EKS Cluster"
}

variable "eks_managed_node_groups_name" {
  type        = string
  description = "EKS Cluster Node Groups Name"
  default     = "eks-group-1"
}

variable "eks_vm_instance_type" {
  type        = string
  description = "VM Instance Type"
  default     = "t2.micro"
}

variable "eks_vm_instance_type_min_size" {
  type        = number
  description = "EKS VM Instance Minimum Size"
  default     = 3
}

variable "eks_vm_instance_type_max_size" {
  type        = number
  description = "EKS VM Instance Maximum Size"
  default     = 5
}

variable "eks_vm_instance_type_desired_size" {
  type        = number
  description = "EKS VM Instance Desired Size"
  default     = 3
}
