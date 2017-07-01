# EC2 Instance Elastic IP
resource "aws_eip" "ec2_instance_eip" {
  vpc = true
}

# EC2 Instance EIP association
resource "aws_eip_association" "ec2_instance_eip_assoc" {
  instance_id   = "${var.ec2_instance_id}"
  allocation_id = "${aws_eip.ec2_instance_eip.id}"
}
