resource "aws_iam_policy" "add_ec2_secondary_ip" {
  name = "${var.name}.add_ec2_secondary_ip"
  path        = "/"
  description = "Policy allows adding Secondary IP addresses to EC2 instance"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "",
            "Effect": "Allow",
            "Action": [
                "ec2:AssignPrivateIpAddresses",
                "ec2:DescribeNetworkInterfaceAttribute",
                "ec2:DescribeNetworkInterfaces"
            ],
            "Resource": [
                "*"
            ]
        }
    ]
}
EOF
}
