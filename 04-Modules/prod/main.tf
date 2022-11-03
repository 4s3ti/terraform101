locals {
  region            = "eu-north-1"
  availability_zone = "eu-north-1a"
  vpc_id        = module.vpc.vpc_id
  subnet_id     = module.vpc.subnet_id

  tags = {
    Name        = "tf101"
    environment = "prod"
  }

  frontend_instance_count = 2
  backend_instance_count = 2
  instance_type = "t3.micro"
  ami           = "ami-051a4a0c60c88f085"
  ssh_key_name  = "MySSHKeyPair"
}


# Terraform configuration specific
terraform {
  required_version = ">= 1.0.0, < 2.0.0"

  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }

 backend "s3" {
   bucket = "MyBucket"
   region = "eu-west-1"
   key    = "tf101/04-Modules/prod/terraform.tfstate"
  }
}

# Configure the AWS Provider
provider "aws" {
  region = local.region
}

module "vpc" {
  source = "../modules/vpc"
  
  availability_zone = local.availability_zone
  tags = local.tags
}

# EC2 Instance with docker and a small webapp
module "FrontEnd" {
  source = "../modules/ec2"
  
  vpc_id            = local.vpc_id
  instance_count    = local.frontend_instance_count
  instance_type     = local.instance_type
  availability_zone = local.availability_zone
  ami               = local.ami
  subnet_id         = local.subnet_id
  key_name          = local.ssh_key_name

  tags = local.tags
}

module "BackEnd" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "4.1.4"
  
  count = local.backend_instance_count

  ami = local.ami  
  instance_type = local.instance_type
  key_name = local.ssh_key_name
  subnet_id = local.subnet_id

  tags = local.tags
}
