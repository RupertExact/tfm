
// Output the ID of the EC2 instance EIP created
output "eip_id" {
  value = "${aws_eip.ec2_instance_eip.id}"
}