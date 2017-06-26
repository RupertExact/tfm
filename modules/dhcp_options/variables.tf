variable "name" {}
#variable "environment" {}
variable "tags" {
  description = "A map of tags to add to all resources"
  default     = { }
}

variable "domain_name_servers" {
  type = "list"
  default = ["AmazonProvidedDNS"]
}

variable "domain_name" { }

variable "vpc_id" { }
