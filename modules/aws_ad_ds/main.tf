// Module for AWS Microsoft Active Directory Services as a Service 

resource "aws_directory_service_directory" "ad_ds" {
  name          = "${var.ad_domain_name}"
  short_name    = "${var.ad_netbios_name}"
  password      = "${var.ad_admin_pwd}"
  size          = "${var.ad_size}"
  type          = "${var.ad_type}"
  vpc_settings {
    vpc_id     = "${var.vpc_id}"
    subnet_ids = ["${var.subnet_ids}"]
  }
}


