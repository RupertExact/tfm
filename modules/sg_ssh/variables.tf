variable "name" {}

variable "tags" {
  description = "A map of tags to add to all resources"
  default     = { }
}

// Module specific variables
variable "security_group_name" {
  description = "The name for the security group"
}

variable "vpc_id" {
  description = "The VPC this security group will go in"
}

variable "source_cidr_block" {
  description = "The source CIDR block to allow traffic from"
}