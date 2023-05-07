# Needed to set the default region
provider "aws" {
  region = var.deployment_region
}

resource "aws_default_vpc" "default" {

}

data "aws_subnet_ids" "subnets" {
  vpc_id = aws_default_vpc.default.id
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
  # version                = "~> 2.12"
}

module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "~> 18.0"
  cluster_name    = "MyPortfolio-cluster"
  cluster_version = "1.22"

  vpc_id     = aws_default_vpc.default.id
  subnet_ids = ["subnet-078976028fc4b3fda", "subnet-0140b8f6acd29d813", "subnet-0b56fcf3559e3b596"] #CHANGE

  eks_managed_node_groups = {
    one = {
      name = "node-group-1"

      instance_types = ["t2.micro"]

      min_size     = 3
      max_size     = 5
      desired_size = 3
    }
  }
}

data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}





