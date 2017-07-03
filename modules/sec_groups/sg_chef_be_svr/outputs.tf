// Output ID SG we made
output "sg_chef_be_svr_id" {
  value = "${aws_security_group.main_security_group.id}"
}