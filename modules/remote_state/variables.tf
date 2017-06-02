variable "name" {}
variable "environment" {}

variable "tags" {
  description = "A map of tags to add to all resources"
  default     = { }
}

variable "s3_key_name" {
    description = "The name of the folder in which to store the remote state"
    default = {}
}

variable "region" {
    description = "The region to host the S3 bucket. Note the bucket is accessible from other regions."
    default = {}
}