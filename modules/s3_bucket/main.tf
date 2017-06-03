resource "aws_s3_bucket" "s3_bucket" {
  bucket = "${var.name}"
  acl    = "${var.acl_type}"
  versioning {
    enabled = "${var.versioning_enabled}"
  }
  tags = "${merge(var.tags, map("Name", format("%s", var.name)))}"
}
