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
   key    = "tf101/05-IsolatingStates/dev/backend/terraform.tfstate"
  }
}

locals {
  region            = "eu-north-1"
  availability_zone = "eu-north-1a"
  vpc_id        = data.terraform_remote_state.vpc.outputs.vpc_id
  subnet_id     = data.aws_subnet.subnet.id

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

data "terraform_remote_state" "vpc" { 
  backend = "s3"

  config = {
    bucket = "MyS3Bucket"
    region = "eu-west-1"
    key    = "tf101/05-IsolatingStates/dev/vpc/terraform.tfstate"
  }
}

data "aws_vpc" "vpc" { 
  id = "vpc-0522251c1b67073e7"
}

data "aws_subnet" "subnet" {
  id = "subnet-0611bac806e2a7aac"
}


module "BackEnd" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "4.1.4"
  
  count = local.instance_count

  ami = local.ami  
  instance_type = local.instance_type
  key_name = local.ssh_key_name
  subnet_id = local.subnet_id

  tags = local.tags
}
