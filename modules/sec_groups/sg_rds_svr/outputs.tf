// Output ID of sg_ssh SG we made
output "sg_rds_svr_id" {
  value = "${aws_security_group.rds_svr_security_group.id}"
}