variable "name" {}

variable "tags" {
  description = "A map of tags to add to all resources"
  default     = { }
}

// Module specific variables
variable "security_group_name" {
  description = "The name for the security group"
  default = {}
}

variable "vpc_id" {
  description = "The VPC this security group will go in"
}

/*
variable "source_cidr_block_https" {
  type = "list"
  description = "The source CIDR block to allow traffic from. Should be ALB/ELB only"
}
*/
variable "source_sg_id_ssh" {
  description = "The source Security Group id to allow traffic from"
}

variable "source_sg_id_chef_all" {
  description = "Sec group id of Automate or Chef Server"
}
