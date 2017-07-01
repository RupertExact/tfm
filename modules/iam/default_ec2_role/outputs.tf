
// Output Name of default instance profile

output "default_inst_profile_name" {
    value = "${aws_iam_instance_profile.defaultInstProfile.name}"
}
output "default_inst_role_name" {
    value = "${aws_iam_role.defaultEc2Role.name}"
}