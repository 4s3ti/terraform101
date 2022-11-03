# Create a VPC 
resource "aws_vpc" "this" {
  cidr_block           = "172.16.0.0/16"
  enable_dns_hostnames = true


  tags = var.tags
}

# Create a subnet with Public IP mapping
resource "aws_subnet" "this" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = "172.16.10.0/24"
  availability_zone       = var.availability_zone
  map_public_ip_on_launch = true


  tags = var.tags
}

# Internet gateway for public access
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = var.tags
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
