// Output ID SG we made
output "sg_alb_id" {
  value = "${aws_security_group.main_security_group.id}"
}