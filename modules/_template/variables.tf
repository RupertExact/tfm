variable "name" {}
variable "environment" {}
variable "tags" {
  description = "A map of tags to add to all resources"
  default     = { }
}