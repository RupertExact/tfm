variable "name" {}
variable "environment" {}
variable "tags" {
  description = "A map of tags to add to all resources"
  default     = { }
}

variable "acl_type" {default = "private"}
variable "versioning_enabled" { default = false }