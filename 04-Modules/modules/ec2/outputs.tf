### Ouputs section
output "instance_ids" {
  description = "EC2 Instance IDs"
  value       = aws_instance.app[*].id
}

output "public_ips" {
  description = "EC2 instance public ips"
  value       = aws_instance.app[*].public_ip
}

