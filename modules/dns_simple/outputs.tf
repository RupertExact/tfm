
// Output the ID of the EC2 instance created
output "fqdn" {
  value = "${aws_route53_record.www.fqdn}"
}