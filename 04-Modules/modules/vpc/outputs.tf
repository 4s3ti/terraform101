output "vpc_id" {
  description = "AWS VPC id"
  value       = aws_vpc.this.id
}

output "subnet_id" {
  description = "AWS Subnet ID"
  value       = aws_subnet.this.id
}
