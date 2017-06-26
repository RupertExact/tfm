
// Output the ID of the EC2 instance created
output "outputs_id" {
  value = "${aws_instance.outputs.id}"
}