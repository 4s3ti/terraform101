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
   key    = "tf101/05-IsolatingStates/dev/frontend/terraform.tfstate"
  }
}

locals {
  region            = "eu-north-1"
  availability_zone = "eu-north-1a"

  tags = {
    Name        = "tf101"
    environment = "dev"
  }

  instance_count = 2
  instance_type = "t3.micro"
  ami           = "ami-051a4a0c60c88f085"
  ssh_key_name  = "MySSHKey"
}

# Configure the AWS Provider
provider "aws" {
  region = local.region
}

#Get data from the remote backend
data "terraform_remote_state" "vpc" { 
  backend = "s3"

  config = {
    bucket = "MyS3Bucket"
    region = "eu-west-1"
    key    = "tf101/05-IsolatingStates/dev/vpc/terraform.tfstate"
  }
}

# EC2 Instance with docker and a small webapp
module "FrontEnd" {
  source = "../../../04-Modules/modules/ec2"
  
  vpc_id            = data.terraform_remote_state.vpc.outputs.vpc_id
  instance_count    = local.instance_count
  instance_type     = local.instance_type
  availability_zone = local.availability_zone
  ami               = local.ami
  subnet_id         = data.terraform_remote_state.vpc.outputs.subnet_id
  key_name          = local.ssh_key_name

  tags = local.tags
}

#outputs
output "public_ips" {
  description = "EC2 Instances public IPS"
  value = module.FrontEnd.public_ips
}

output "Instance_IDs" {
  description = "EC2 Instances public IPS"
  value = module.FrontEnd.instance_ids
}
