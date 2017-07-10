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

variable "source_cidr_block_ssh" {
  type = "list"
  description = "The source CIDR block to allow traffic from"
}
variable "source_cidr_block_pgsql" {
  type = "list"
  description = "The source CIDR block to allow traffic from"
}
variable "source_cidr_block_etcd" {
  type = "list"
  description = "The source CIDR block to allow traffic from"
}
variable "source_cidr_block_ldrl" {
  type = "list"
  description = "The source CIDR block to allow traffic from"
}
variable "source_cidr_block_els" {
  type = "list"
  description = "The source CIDR block to allow traffic from"
}

variable "source_sg_id_ssh" {
  type = "list"
  description = "The source Security Group id to allow traffic from"
}
variable "source_sg_id_pgsql" {
  type = "list"
  description = "The source Security Group id to allow traffic from"
}
variable "source_sg_id_etcd" {
  type = "list"
  description = "The source Security Group id to allow traffic from"
}
variable "source_sg_id_ldrl" {
  type = "list"
  description = "The source Security Group id to allow traffic from"
}
variable "source_sg_id_els" {
  type = "list"
  description = "The source Security Group id to allow traffic from"
}



