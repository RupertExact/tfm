
output "policy_id" {
    value = "${aws_iam_policy.main.id}"
}

output "policy_arn" {
    value = "${aws_iam_policy.main.arn}"
}
