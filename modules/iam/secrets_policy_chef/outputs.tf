
output "secrets_access_id" {
    value = "${aws_iam_policy.main.id}"
}

output "secrets_access_arn" {
    value = "${aws_iam_policy.main.arn}"
}


