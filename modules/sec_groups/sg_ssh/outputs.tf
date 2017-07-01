// Output ID of sg_ssh SG we made
output "sg_ssh_id" {
  value = "${aws_security_group.ssh_security_group.id}"
}