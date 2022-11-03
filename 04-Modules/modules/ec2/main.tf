# Create a security group that allows http traffic
resource "aws_security_group" "this" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow Port 80"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }


  tags = var.tags
}

# EC2 Instance with docker and a small webapp
resource "aws_instance" "app" {
  count = var.instance_count

  instance_type          = var.instance_type
  availability_zone      = var.availability_zone
  ami                    = var.ami
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [aws_security_group.this.id]
  key_name               = var.key_name

  associate_public_ip_address = true

  user_data = <<EOF
#! /bin/bash
sudo apt update && sudo apt install -y docker.io
sudo docker pull containous/whoami:latest
sudo docker run -d -p 80:80 --name iamfoo containous/whoami
echo "Docker Setup finished"
 EOF


  tags = var.tags
}
