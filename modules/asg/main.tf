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
  # We want this to explicitly depend on the launch config above
  depends_on = ["aws_launch_configuration.launch_config"]

  name = "${var.svr_name_prefix}${lower(var.environment)}-${lower(var.svr_type)}-asg"

  # The chosen availability zones *must* match the AZs the VPC subnets are tied to.
  availability_zones = ["${split(",", var.availability_zones)}"]
  vpc_zone_identifier = ["${split(",", var.vpc_zone_subnets)}"]

  # Uses the ID from the launch config created above
  launch_configuration = "${aws_launch_configuration.launch_config.id}"

  max_size          = "${var.asg_number_of_instances}"
  min_size          = "${var.asg_minimum_number_of_instances}"
  desired_capacity  = "${var.asg_number_of_instances}"

  health_check_grace_period = "${var.health_check_grace_period}"
  health_check_type = "${var.health_check_type}"

  load_balancers = ["${module.aws_elb.elb}"]

  tags {
        // created_by = "${lookup(var.tags,"created_by")}"
        // Takes the instance_name input variable and adds
        //  the count.index to the name., e.g.
        //  "example-host-web-1"
        Name = "${var.svr_name_prefix}${lower(var.environment)}-${lower(var.svr_type)}-asg"
        Environment = "${var.environment}"
        Terraform = "True"
    }

}

//
// Module: tf_aws_elb/elb_https
//

// ELB Resource for Module
// A note about instances:
// - This module assumes your instances will be made
//   by an ASG and the ASG will associate them with
//   the ELB.
resource "aws_elb" "elb" {
  name = "${var.svr_name_prefix}${lower(var.environment)}-${lower(var.svr_type)}-elb"
  #subnets = ["${var.subnet_az1}","${var.subnet_az2}"]
  subnets = "${var.vpc_zone_subnets}"
  internal = "${var.elb_is_internal}"
  security_groups = ["${var.elb_security_group}"]

  listener {
    instance_port = "${var.backend_port}"
    instance_protocol = "${var.backend_protocol}"
    lb_port = 443
    lb_protocol = "https"
    ssl_certificate_id = "${var.ssl_certificate_id}"
  }

  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    target = "${var.health_check_target}"
    interval = 30
  }

  cross_zone_load_balancing = true
}
