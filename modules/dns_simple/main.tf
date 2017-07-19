resource "aws_route53_record" "www" {
  zone_id = "${var.zone_id}"
  name    = "${var.name}"
  type    = "${var.record_type}"
  ttl     = "${var.ttl}"
  records = ["${var.records}"]
}

