/*
 * Module: tf_aws_asg_elb
 *
 * Outputs:
 *   - launch_config_id
 *   - asg_id
 */

# Output the ID of the Launch Config
output "launch_config_id" {
    value = "${aws_launch_configuration.launch_config.id}"
}

# Output the ID of the Launch Config
output "asg_id" {
    value = "${aws_autoscaling_group.main_asg.id}"
}

//
// Module: tf_aws_elb/elb_https
//

output "elb_id" {
  value = "${aws_elb.elb.id}"
}

output "elb_name" {
  value = "${aws_elb.elb.name}"
}

output "elb_dns_name" {
  value = "${aws_elb.elb.dns_name}"
}