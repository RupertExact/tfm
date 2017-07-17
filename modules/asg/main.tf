/*
 * Module: tf_aws_asg_elb
 *
 * This template creates the following resources
 *   - A launch configuration
 *   - A auto-scaling group
 *
 * It requires you create an ELB instance before you use it.
 */

resource "aws_launch_configuration" "launch_config" {
  name = "${var.lc_name}"
  image_id = "${var.ami_id}"
  instance_type = "${var.instance_type}"
  iam_instance_profile = "${var.iam_instance_profile}"
  key_name = "${var.key_name}"
  security_groups = ["${var.security_group}"]
  user_data = "${file(var.user_data)}"
}

resource "aws_autoscaling_group" "main_asg" {
  #availability_zones        = ["us-east-1a"]
  vpc_zone_identifier       = ["${var.vpc_zone_identifier}"]
  name                      = "${var.name}"
  max_size                  = "${var.asg_max_size}"
  min_size                  = "${var.asg_min_size}"
  health_check_grace_period = "${var.health_check_grace_period}"
  health_check_type         = "${var.health_check_type}"
  default_cooldown          = "${var.default_cooldown}"
  desired_capacity          = "${var.asg_max_size}"
  force_delete              = true
  #placement_group           = "${aws_placement_group.test.id}"
  launch_configuration      = "${aws_launch_configuration.launch_config.name}"
  target_group_arns         = ["${var.target_group_arns}"]
  #tags = "${merge(var.tags, map("Name", format("%s", var.name)))}"
   lifecycle {
    create_before_destroy = true
  }
  tags = [
      {
          key                   = "Name"
          value                 = "${var.name}"
          propagate_at_launch   = true
      },
      {
          key                   = "Terraform"
          value                 = "true"
          propagate_at_launch   = true
      },
      {
          key                   = "Environment"
          value                 = "${var.environment}"
          propagate_at_launch   = true
      }
  ]

}

resource "aws_autoscaling_attachment" "asg_attachment_main" {
  autoscaling_group_name = "${aws_autoscaling_group.main_asg.id}"
  alb_target_group_arn   = "${var.alb_target_group_arn}"
}