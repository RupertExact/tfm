variable "name" {}
#variable "environment" {}
variable "tags" {
  description = "A map of tags to add to all resources"
  default     = { }
}

variable "ad_domain_name" {
  description = "the name of the AD domain e.g. mydomain.com. Keep in mind that you will run in to split brain type problems if this is the same as a DNS hosted zone in Route53"
}
variable "ad_netbios_name" {
  description = "AD Netbios name (short name)"
}
variable "ad_admin_pwd" {
  description = "directory administrator password"
}

variable "ad_size" {
  
  description = "AD Size - Small / Large. Only required if using AD Connector or SimpleAD"
}

variable "vpc_id" {
  description = ""
}

variable "subnet_ids" {
  type = "list"
  
  description = "Subnet IDs. 2 required in different AZs"
}

variable "ad_type" {
  default = "MicrosoftAD"
  description = "AD type. MicrosoftAD or SimpleAD"
}