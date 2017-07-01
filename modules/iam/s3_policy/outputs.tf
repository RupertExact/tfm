
output "s3_ro_access_id" {
    value = "${aws_iam_policy.s3_ro_access.id}"
}

output "s3_ro_access_arn" {
    value = "${aws_iam_policy.s3_ro_access.arn}"
}
