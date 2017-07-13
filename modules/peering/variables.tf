variable "name" {}
#variable "environment" {}
variable "tags" {
  description = "A map of tags to add to all resources"
  default     = { }
}

variable "peer_owner_id" {}
variable "peer_vpc_id" {}
variable "vpc_id" {}
variable "auto_accept" {}
variable "vpc_cidr" {}
variable "peer_cidr" {}
variable "peer_prv_route_table_ids" {
  default = []
}
variable "peer_pub_route_table_ids" {
  default = []
}
variable "vpc_prv_route_table_ids" {
  default = []
}
variable "azs" {
  default = []
}
variable "mgt_vpc_azs" {
  default = []
}