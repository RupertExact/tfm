#variable "name" {}
variable "environment" {}
variable "tags" {
  description = "A map of tags to add to all resources"
  default     = { }
}

// Module specific variables

variable "key_name" {
  description = "Used to populate the Name tag. This is done in main.tf"
}

variable "instance_type" {}

variable "subnet_id" {
  description = "The VPC subnet the instance(s) will go in"
}

variable "ami_id" {
  description = "The AMI to use"
}

variable "number_of_instances" {
  description = "number of instances to make"
  default = 1
}

#variable "user_data" {
#  description = "The path to a file with user_data for the instances"
#}

variable "tags" {
  default = { }
}

variable "enable_monitoring" {
  default = true
}

variable "root_vol_size" {
  description = "EBS root block volume size"
  default = 50
}

variable "svr_type" {
  description = "Server type for chef provisioning - CS, DC, WS, IS, IW, SV, NI, SF, SI, etc."
}

variable "chef_role" {  
  description = "Chef role e.g. web-ws"
}

variable "chef_env" { 
  description = "Chef environment e.g. dev, prod"
}

variable "chefClientVer" {
  description = "Chef Client version"
}
variable "chefOrg" {
  default = "exactonline"
}
variable "chefAutoFqdn" {
  default = "automate.exactonline.io"
}
variable "chefServerEndpoint" {
  default  = "https://chef.exactonline.io"
}

variable "dataToken" {
  description = "Chef Automate data token"
}

variable "iam_instance_profile" {}
variable "vpc_security_group_ids" {}
variable "private_ip" {}

// Variables for providers used in this module
// variable "aws_access_key" {}
// variable "aws_secret_key" {}
variable "aws_region" {}