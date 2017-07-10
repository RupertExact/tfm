#variable "name" {}
variable "environment" {}
variable "tags" {
  description = "A map of tags to add to all resources"
  default     = { }
}
variable "svr_name_prefix" {}

// Module specific variables

variable "key_name" {
  description = "Used to populate the Name tag. This is done in main.tf"
}

variable "instance_type" {}

variable "subnet_id" {
  type = "list"
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

variable "enable_monitoring" {
  default = true
}

variable "root_vol_type" {
  description = "Volume type - gp2, io1, standard"
}
variable "root_vol_iops" {
  description = "Specify IOPS for io1 volumes. For gp2 disks IOPS = 3x volume size"
}
variable "root_vol_size" {
  description = "EBS root block volume size"
  default = 50
}
variable "subnets" {
  #type = "list"
  description = "VPC CIDR"
}
/*
variable "pub_subnets" {
  type = "list"
  description = "Delimited list of subnets containing Chef FE or BE servers"
}
variable "prv_subnets" {
  type = "list"
  description = "Delimited list of subnets containing Chef FE or BE servers"
}
*/
variable "chef_server_ver" {
  description = "Chef Server version"
}

variable "svr_type" {
  description = "Server type for chef provisioning - CS, DC, WS, IS, IW, SV, NI, SF, SI, etc."
}
/*
variable "chef_role" {  
  description = "Chef role e.g. web-ws"
}

variable "chef_env" { 
  description = "Chef environment e.g. dev, prod"
}

variable "chef_client_ver" {
  description = "Chef Client version"
}

variable "chef_org" {
  default = "exactonline"
}
variable "chef_auto_fqdn" {
  default = "automate.exactonline.io"
}
variable "chef_server_endpoint" {
  default  = "https://chef.exactonline.io"
}

variable "data_token" {
  description = "Chef Automate data token"
}
*/
variable "iam_instance_profile" {}
variable "security_group_ids" {
  type = "list"
}
variable "private_ip" {}

// Variables for providers used in this module
// variable "aws_access_key" {}
// variable "aws_secret_key" {}
variable "aws_region" {}

variable "user_data_file" {}