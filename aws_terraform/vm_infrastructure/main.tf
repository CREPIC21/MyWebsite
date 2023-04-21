terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.deployment_region
}

# Create a VPC
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cider_block
  tags = {
    "Name" = "${var.main_vpc_name}"
  }
}

# Create a subnet in the VPC
resource "aws_subnet" "web" {
  vpc_id            = aws_vpc.main.id # mapping the subnet to the VPC
  cidr_block        = var.web_subnet
  availability_zone = var.subnet_zone # think of a avaliability zone as data center in the region
  tags = {
    "Name" = "${var.main_vpc_name} Subnet"
  }
}


# Create internet gateway that handels the internet traffic
resource "aws_internet_gateway" "my_web_igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    "Name" = "${var.main_vpc_name} IGW"
  }
}

# Create route table associated with internet gateway
resource "aws_default_route_table" "main_vpc_default_rt" {
  default_route_table_id = aws_vpc.main.default_route_table_id

  route {
    cidr_block = var.main_vpc_default_rt_cidr_block # all traffic that is not local to VPC will be handeled by the internet gateway
    gateway_id = aws_internet_gateway.my_web_igw.id
  }

  tags = {
    "Name" = "${var.main_vpc_name} Route Table"
  }
}

# Configure the default security group of the VPC to allow incoming traffic and outgoing traffic
resource "aws_default_security_group" "default_sec_group" {
  vpc_id = aws_vpc.main.id

  # creating the ingress rules using dynamic blocks
  dynamic "ingress" {
    for_each = var.ingress_ports
    iterator = iport
    content {
      from_port   = iport.value
      to_port     = iport.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # any protocol
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" = "${var.main_vpc_name} Security Group"
  }

}

# Create a key-pair resource that will be used to control login access to EC2 instance, giving the path to the public key
resource "aws_key_pair" "test_ssh_key" {
  key_name   = var.test_ssh_key_name
  public_key = file(var.ssh_public_key)
}

# Create data source resource to get EC2 ami dynamically fetched from the provider
data "aws_ami" "latest_amazon_linux2" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-*-x86_64-gp2"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]

  }
}

# Create EC2 instance
resource "aws_instance" "my_vm" {
  #   ami                         = "ami-06616b7884ac98cdd"
  ami                         = data.aws_ami.latest_amazon_linux2.id
  instance_type               = var.vm_instance_type
  subnet_id                   = aws_subnet.web.id                                 # mapping to the our created subnet so the EC2 will be launched in that subnet and not in the default one
  vpc_security_group_ids      = [aws_default_security_group.default_sec_group.id] # mapping to the our created security group
  associate_public_ip_address = true                                              # public IP that is required to access the EC2 from the internet
  # key_name                    = "production_ssh_key"                            # telling AWS to use specific key-pair to authenticate the access to the EC2
  key_name  = aws_key_pair.test_ssh_key.key_name
  user_data = file("deploymentScript.sh")
  tags = {
    "Name" = var.my_vm_name
  }
}

### IMPORTANT ###
/*
If creating a key-pair via AWS UI, then key-pair needs to be created before creating a EC2 resource
- when creating key-pair in AWS UI make sure you are creating it in the same region where you are creating resources
- once the key-pair is downloaded you need to change the file permissions: chmod 400 production_ssh_key.pem

If creating key-pair loccaly use the below approach
- run command: ssh-keygen -t rsa -b 2048 -C 'test key' -N '' -f ~/Desktop/Terraform_AWS/test_rsa
- once the key-pair is created you need to change the file permissions: chmod 400 test_rsa
- public key should be on the server/VM and the private key should be on the client
*/