variable "name" {}
#variable "environment" {}
variable "tags" {
  description = "A map of tags to add to all resources"
  default     = { }
}
variable "svr_name_prefix" {}
variable "environment" {}
variable "svr_type" {}
/*
 * Module: tf_aws_asg_elb
 */

#
# Launch Configuration Variables
#
variable "lc_name" {}
variable "ami_id" {
  description = "The AMI to use with the launch configuration"
}
variable "instance_type" {}
variable "iam_instance_profile" {
  description = "The IAM role the launched instance will use"
}
variable "key_name" {
  description = "The SSH public key name (in EC2 key-pairs) to be injected into instances"
}
variable "security_group" {
  description = "ID of SG the launched instance will use"
}
variable "user_data" {
  description = "The path to a file with user_data for the instances"
}

#
# Auto-Scaling Group
#
variable "asg_name" {}

/* We use this to populate the following ASG settings
 * - max_size
 * - desired_capacity
 */
variable "asg_number_of_instances" {
  description = "The number of instances we want in the ASG"
}

/*
 * Can be set to 0 if you never want the ASG to replace failed instances
 */
variable "asg_minimum_number_of_instances" {
  description = "The minimum number of instances the ASG should maintain"
  default = 1
}

variable "health_check_grace_period" {
  description = "Number of seconds for a health check to time out"
  default = 300
}
/*
 * Types available are:
 *   - ELB
 *   - EC2
 *
 *   @see-also: http://docs.aws.amazon.com/cli/latest/reference/autoscaling/create-auto-scaling-group.html#options
 */
variable "health_check_type" {
  description = "The health check used by the ASG to determine health"
  default = "ELB"
}

variable "load_balancer_names" {
  description = "A comma seperated list string of ELB names the ASG should associate instances with"
}

/*
 * A string list of AZs, ex:
 * "us-east-1a,us-east-1c,us-east-1e"
 */
variable "availability_zones" {
  description = "A comma seperated list string of AZs the ASG will be associated with"
}

/*
 * A string list of VPC subnet IDs, ex:
 * "subnet-d2t4sad,subnet-434ladkn"
 */
variable "vpc_zone_subnets" {
  description = "A comma seperated list string of VPC subnets to associate with ASG, should correspond with var.availability_zones zones"
}

//
// Module: tf_aws_elb/elb_https
//

// Module specific variables

#variable "elb_name" {}

variable "elb_is_internal" {
  description = "Determines if the ELB is internal or not"
  default = false
  // Defaults to false, which results in an external IP for the ELB
}

variable "elb_security_group" {}

// See README.md for details on finding the
// ARN of an SSL certificate in EC2
variable "ssl_certificate_id" {
  description = "The ARN of the SSL Certificate in EC2"
}
/*
variable "subnet_az1" {
  description = "The subnet for AZ1"
}

variable "subnet_az2" {
  description = "The subnet for AZ2"
}
*/
variable "backend_port" {
  description = "The port the service on the EC2 instances listens on"
}

variable "backend_protocol" {
 description = "The protocol the backend service speaks"
 // Possible options are
 // - http
 // - https
 // - tcp
 // - ssl (secure tcp)
}

variable "health_check_target" {
  description = "The URL the ELB should use for health checks"
  // This is primarily used with `http` or `https` backend protocols
  // The format is like `HTTPS:443/health`
}

// Variables for providers used in this module
variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_region" {}