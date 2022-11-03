variable "vpc_id" {
  type        = string
  description = "VPC to place security group"
}

variable "instance_count" {
  type        = number
  description = "The number of desired ec2 instanvces"
}

variable "instance_type" {
  type        = string
  description = "EC2 Instance Type"
}

variable "ami" {
  type        = string
  description = "The AMI ID to be used"
}

variable "availability_zone" {
  type        = string
  description = "Availability zone to place the instance"
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID to place instnace"
}

variable "key_name" {
  type        = string
  description = "Name of the ssh key pair to be used"
}

variable "tags" {
  type        = map(string)
  description = "Tags to be added to resrouces"
  default     = null
}
