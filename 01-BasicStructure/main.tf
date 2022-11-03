# Terraform configuration specific
terraform {
  required_version = ">= 1.0.0, < 2.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "eu-north-1"
}

# Create a VPC 
resource "aws_vpc" "this" {
  cidr_block = "172.16.0.0/16"
  enable_dns_hostnames = true
  

  tags = {
    Name = "tf101"
  }
}

# Create a subnet with Public IP mapping
resource "aws_subnet" "this" {
  vpc_id           = aws_vpc.this.id
  cidr_block        = "172.16.10.0/24"
  availability_zone = "eu-north-1a"
  map_public_ip_on_launch = true
  

  tags = {
    Name = "tf101"
  }
}

# Internet gateway for public access
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "tf101"
  }
}

# Routing table for public subnet
resource "aws_route_table" "this" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }
}


# Associate the routing table to public subnet
resource "aws_route_table_association" "route_table_association" {

  subnet_id      = aws_subnet.this.id
  route_table_id = aws_route_table.this.id
}



# Create a security group that allows http traffic
resource "aws_security_group" "this" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.this.id

  ingress {
    description      = "Allow Port 80"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  ingress {
    description      = "Allow ssh"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "tf101"
  }
}

# EC2 Instance with docker and a small webapp
resource "aws_instance" "app" {
  instance_type_     = "t3.micro"
  availability_zone = "eu-north-1a"
  ami               = "ami-051a4a0c60c88f085"
  subnet_id         = aws_subnet.this.id
  security_groups   = [aws_security_group.this.id]
  key_name          = "MySSHKey"

  associate_public_ip_address  = true

  user_data = <<EOF
#! /bin/bash
sudo apt update && sudo apt install -y docker.io
sudo docker pull containous/whoami:latest
sudo docker run -d -p 80:80 --name iamfoo containous/whoami
echo "Docker Setup finished"
 EOF

  tags = {
    Name = "tf101"
  }
}


### Ouputs section
output "instance_id" {
  value = aws_instance.app.id
}

output "public_ip" {
  value = aws_instance.app.public_ip
}
