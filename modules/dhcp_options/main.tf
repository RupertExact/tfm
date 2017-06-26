resource "aws_vpc_dhcp_options" "dhcp_options" {
    domain_name = "${var.domain_name}"
    domain_name_servers = "${var.domain_name_servers}"
    #ntp_servers = ["127.0.0.1"]
    #netbios_name_servers = ["127.0.0.1"]
    #netbios_node_type = 2

    tags = "${merge(var.tags, map("Name", format("%s", var.name)))}"
}

resource "aws_vpc_dhcp_options_association" "dhcp_options_assoc" {
    vpc_id = "${var.vpc_id}"
    dhcp_options_id = "${aws_vpc_dhcp_options.dhcp_options.id}"
}