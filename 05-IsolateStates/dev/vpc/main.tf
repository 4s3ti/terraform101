# Terraform configuration specific
terraform {
  required_version = ">= 1.0.0, < 2.0.0"

  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }

 backend "s3" {
   bucket = "MyS3Bucket"
   region = "eu-west-1"
   key    = "tf101/05-IsolatingStates/dev/vpc/terraform.tfstate"
  }
}

## Local Variables
locals {
  region            = "eu-north-1"
  availability_zone = "eu-north-1a"

  tags = {
    Name        = "tf101"
    environment = "dev"
  }
}

# Configure the AWS Provider
provider "aws" {
  region = local.region
}

module "vpc" {
  source = "../../../04-Modules/modules/vpc"
  
  availability_zone = local.availability_zone
  tags = local.tags
}

#Outputs
output "vpc_id" {
  description = "VPC id"
  value = module.vpc.vpc_id
}

output "subnet_id" {
  description = "subned it"
  value = module.vpc.subnet_id
}
