
output "secrets_access_id" {
    value = "${aws_iam_policy.secrets_access.id}"
}

output "secrets_access_arn" {
    value = "${aws_iam_policy.secrets_access.arn}"
}


