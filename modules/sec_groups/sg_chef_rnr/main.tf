// Security Group Resource for Module
resource "aws_security_group" "main_security_group" {
  name        = "${var.name}"
  description = "Security Group ${var.name}"
  vpc_id      = "${var.vpc_id}"
  tags = "${merge(var.tags, map("Name", format("%s", var.name)))}"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

// allows all traffic between Chef Server & Chef Automate
resource "aws_security_group_rule" "allow_all" {
  type            = "ingress"
  from_port       = 0
  to_port         = 0
  protocol        = -1
  #cidr_blocks     = ["${var.source_cidr_block_ssh}"]
  #prefix_list_ids = ["pl-12c4e678"]  
  security_group_id = "${aws_security_group.main_security_group.id}"
  source_security_group_id = "${var.source_sg_id_chef_all}"
}

// allows traffic for TCP 22 (SSH) from SSH Server
resource "aws_security_group_rule" "allow_ssh_ssh" {
  type            = "ingress"
  from_port       = 22
  to_port         = 22
  protocol        = "tcp"
  #cidr_blocks     = ["${var.source_cidr_block_ssh}"]
  #prefix_list_ids = ["pl-12c4e678"]  
  security_group_id = "${aws_security_group.main_security_group.id}"
  source_security_group_id = "${var.source_sg_id_ssh}"
}
