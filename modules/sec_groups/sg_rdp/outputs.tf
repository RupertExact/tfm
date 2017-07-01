// Output ID of sg_ssh SG we made
output "sg_rdp_id" {
  value = "${aws_security_group.rdp_security_group.id}"
}