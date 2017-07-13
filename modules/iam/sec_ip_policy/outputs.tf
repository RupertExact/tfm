



output "add_ec2_secondary_ips_id" {
    value = "${aws_iam_policy.add_ec2_secondary_ip.id}"
}

output "add_ec2_secondary_ips_arn" {
    value = "${aws_iam_policy.add_ec2_secondary_ip.arn}"
}