

terraform {
  backend "s3" {
    bucket = "${var.name}"
    key    = "${var.key_name/terraform.tfstate}"
    region = "${var.region}"
  }
}