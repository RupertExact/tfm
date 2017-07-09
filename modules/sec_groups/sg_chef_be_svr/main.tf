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

// allows elasticsearch traffic from Chef FE servers and between Chef BE servers
resource "aws_security_group_rule" "allow_els" {
  type            = "ingress"
  from_port       = 9200
  to_port         = 9400
  protocol        = "tcp"
  cidr_blocks     = ["${var.source_cidr_block_els}"]
  #prefix_list_ids = ["pl-12c4e678"]  
  security_group_id = "${aws_security_group.main_security_group.id}"
  #source_security_group_id = ""
}
// allows leaderl traffic from Chef FE servers and between Chef BE servers
resource "aws_security_group_rule" "allow_ldrl" {
  type            = "ingress"
  from_port       = 7331
  to_port         = 7331
  protocol        = "tcp"
  cidr_blocks     = ["${var.source_cidr_block_ldrl}"]
  #prefix_list_ids = ["pl-12c4e678"]  
  security_group_id = "${aws_security_group.main_security_group.id}"
  #source_security_group_id = ""
}
// allows postgresql traffic from Chef FE servers and between Chef BE servers
resource "aws_security_group_rule" "allow_postgresql" {
  type            = "ingress"
  from_port       = 5432
  to_port         = 5432
  protocol        = "tcp"
  cidr_blocks     = ["${var.source_cidr_block_pgsql}"]
  #prefix_list_ids = ["pl-12c4e678"]  
  security_group_id = "${aws_security_group.main_security_group.id}"
  #source_security_group_id = ""
}
// allows ETCD trafic from Chef FE Servers and between Chef BE servers
resource "aws_security_group_rule" "allow_etcd" {
  type            = "ingress"
  from_port       = 2378
  to_port         = 2379
  protocol        = "tcp"
  cidr_blocks     = ["${var.source_cidr_block_etcd}"]
  #prefix_list_ids = ["pl-12c4e678"]  
  security_group_id = "${aws_security_group.main_security_group.id}"
  #source_security_group_id = ""
}
// allows traffic for TCP 22 (SSH)
resource "aws_security_group_rule" "allow_ssh" {
  type            = "ingress"
  from_port       = 22
  to_port         = 22
  protocol        = "tcp"
  cidr_blocks     = ["${var.source_cidr_block_ssh}"]
  #prefix_list_ids = ["pl-12c4e678"]  
  security_group_id = "${aws_security_group.main_security_group.id}"
  #source_security_group_id = ""
}



