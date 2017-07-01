// Output ID of sg_ssh SG we made
output "sg_vault_svr_id" {
  value = "${aws_security_group.vault_security_group.id}"
}