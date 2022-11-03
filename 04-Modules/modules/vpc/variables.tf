variable "availability_zone" {
  type        = string
  description = "availability zone to create vpc resources"
}

variable "tags" {
  type        = map(string)
  description = "Tags to be added to resrouces"
  default     = null
}
