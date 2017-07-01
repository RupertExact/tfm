// Output ID of sg_ssh SG we made
output "sg_tst_svr_id" {
  value = "${aws_security_group.tst_svr_security_group.id}"
}