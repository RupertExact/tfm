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

// Rules for Chef Backend Servers

// allows elasticsearch traffic from Chef FE servers and between Chef BE servers
resource "aws_security_group_rule" "allow_els_cbe" {
  type            = "ingress"
  from_port       = 9200
  to_port         = 9400
  protocol        = "tcp"
  #cidr_blocks     = ["${var.source_cidr_block_els}"]
  #prefix_list_ids = ["pl-12c4e678"]  
  security_group_id = "${aws_security_group.main_security_group.id}"
  source_security_group_id = "${aws_security_group.main_security_group.id}"
}
// allows leaderl traffic from Chef FE servers and between Chef BE servers
resource "aws_security_group_rule" "allow_ldrl_cbe" {
  type            = "ingress"
  from_port       = 7331
  to_port         = 7331
  protocol        = "tcp"
  #cidr_blocks     = ["${var.source_cidr_block_ldrl}"]
  #prefix_list_ids = ["pl-12c4e678"]  
  security_group_id = "${aws_security_group.main_security_group.id}"
  source_security_group_id = "${aws_security_group.main_security_group.id}"
}
// allows postgresql traffic from Chef FE servers and between Chef BE servers
resource "aws_security_group_rule" "allow_postgresql_cbe" {
  type            = "ingress"
  from_port       = 5432
  to_port         = 5432
  protocol        = "tcp"
  #cidr_blocks     = ["${var.source_cidr_block_pgsql}"]
  #prefix_list_ids = ["pl-12c4e678"]  
  security_group_id = "${aws_security_group.main_security_group.id}"
  source_security_group_id = "${aws_security_group.main_security_group.id}"
}
// allows ETCD trafic from Chef FE Servers and between Chef BE servers
resource "aws_security_group_rule" "allow_etcd_cbe" {
  type            = "ingress"
  from_port       = 2379
  to_port         = 2380
  protocol        = "tcp"
  #cidr_blocks     = ["${var.source_cidr_block_etcd}"]
  #prefix_list_ids = ["pl-12c4e678"]  
  security_group_id = "${aws_security_group.main_security_group.id}"
  source_security_group_id = "${aws_security_group.main_security_group.id}"
}
// allows traffic for TCP 22 (SSH)
resource "aws_security_group_rule" "allow_ssh_cbe" {
  type            = "ingress"
  from_port       = 22
  to_port         = 22
  protocol        = "tcp"
  #cidr_blocks     = ["${var.source_cidr_block_ssh}"]
  #prefix_list_ids = ["pl-12c4e678"]  
  security_group_id = "${aws_security_group.main_security_group.id}"
  source_security_group_id = "${aws_security_group.main_security_group.id}"
}

// Rules for Chef Frontend Servers

// allows elasticsearch traffic from Chef FE servers and between Chef BE servers
resource "aws_security_group_rule" "allow_els_cfe" {
  type            = "ingress"
  from_port       = 9200
  to_port         = 9400
  protocol        = "tcp"
  #cidr_blocks     = ["${var.source_cidr_block_els}"]
  #prefix_list_ids = ["pl-12c4e678"]  
  security_group_id = "${aws_security_group.main_security_group.id}"
  source_security_group_id = "${var.source_sg_id_cfe}"
}
// allows leaderl traffic from Chef FE servers and between Chef BE servers
resource "aws_security_group_rule" "allow_ldrl_cfe" {
  type            = "ingress"
  from_port       = 7331
  to_port         = 7331
  protocol        = "tcp"
  #cidr_blocks     = ["${var.source_cidr_block_ldrl}"]
  #prefix_list_ids = ["pl-12c4e678"]  
  security_group_id = "${aws_security_group.main_security_group.id}"
  source_security_group_id = "${var.source_sg_id_cfe}"
}
// allows postgresql traffic from Chef FE servers and between Chef BE servers
resource "aws_security_group_rule" "allow_postgresql_cfe" {
  type            = "ingress"
  from_port       = 5432
  to_port         = 5432
  protocol        = "tcp"
  #cidr_blocks     = ["${var.source_cidr_block_pgsql}"]
  #prefix_list_ids = ["pl-12c4e678"]  
  security_group_id = "${aws_security_group.main_security_group.id}"
  source_security_group_id = "${var.source_sg_id_cfe}"
}
// allows ETCD trafic from Chef FE Servers and between Chef BE servers
resource "aws_security_group_rule" "allow_etcd_cfe" {
  type            = "ingress"
  from_port       = 2379
  to_port         = 2380
  protocol        = "tcp"
  #cidr_blocks     = ["${var.source_cidr_block_etcd}"]
  #prefix_list_ids = ["pl-12c4e678"]  
  security_group_id = "${aws_security_group.main_security_group.id}"
  source_security_group_id = "${var.source_sg_id_cfe}"
}
// allows traffic for TCP 22 (SSH)
resource "aws_security_group_rule" "allow_ssh_cfe" {
  type            = "ingress"
  from_port       = 22
  to_port         = 22
  protocol        = "tcp"
  #cidr_blocks     = ["${var.source_cidr_block_ssh}"]
  #prefix_list_ids = ["pl-12c4e678"]  
  security_group_id = "${aws_security_group.main_security_group.id}"
  source_security_group_id = "${var.source_sg_id_cfe}"
}

// Rules for SSH Server

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

