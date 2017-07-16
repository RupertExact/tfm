
output "s3_ro_access_id" {
    value = "${aws_iam_policy.main.id}"
}

output "s3_ro_access_arn" {
    value = "${aws_iam_policy.main.arn}"
}

output "policy_id" {
    value = "${aws_iam_policy.main.id}"
}

output "policy_arn" {
    value = "${aws_iam_policy.main.arn}"
}