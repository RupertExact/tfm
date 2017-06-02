

terraform {
  backend "s3" {
    bucket = "${var.name}"
    key    = "${var.s3_key_name/terraform.tfstate}"
    region = "${var.region}"
  }
}