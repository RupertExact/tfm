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

// allows traffic for TCP 3389 (RDP)
resource "aws_security_group_rule" "allow_rdp" {
  type            = "ingress"
  from_port       = 3389
  to_port         = 3389
  protocol        = "tcp"
  #cidr_blocks     = ["${var.source_cidr_block_rdp}"]
  #prefix_list_ids = ["pl-12c4e678"]  
  security_group_id = "${aws_security_group.main_security_group.id}"
  source_security_group_id = "${var.source_sg_id_rdp}"
}

// allows  traffic between database servers
resource "aws_security_group_rule" "allow_all_dbs" {
  type            = "ingress"
  from_port       = 0
  to_port         = 0
  protocol        = -1
  #cidr_blocks     = ["${var.source_cidr_block_els}"]
  #prefix_list_ids = ["pl-12c4e678"]  
  security_group_id = "${aws_security_group.main_security_group.id}"
  source_security_group_id = "${aws_security_group.main_security_group.id}"
}

// allows traffic for TCP 1433 (RDP)
resource "aws_security_group_rule" "allow_dbs_svc" {
  type            = "ingress"
  from_port       = 1433
  to_port         = 1433
  protocol        = "tcp"
  #cidr_blocks     = ["${var.source_cidr_block_rdp}"]
  #prefix_list_ids = ["pl-12c4e678"]  
  security_group_id = "${aws_security_group.main_security_group.id}"
  source_security_group_id = "${var.source_sg_id_svc}"
}
// allows traffic for TCP 1433 (RDP)
resource "aws_security_group_rule" "allow_dbs_csh" {
  type            = "ingress"
  from_port       = 1433
  to_port         = 1433
  protocol        = "tcp"
  #cidr_blocks     = ["${var.source_cidr_block_rdp}"]
  #prefix_list_ids = ["pl-12c4e678"]  
  security_group_id = "${aws_security_group.main_security_group.id}"
  source_security_group_id = "${var.source_sg_id_csh}"
}

// allows traffic for TCP 1433 (RDP)
resource "aws_security_group_rule" "allow_dbs_web" {
  type            = "ingress"
  from_port       = 1433
  to_port         = 1433
  protocol        = "tcp"
  #cidr_blocks     = ["${var.source_cidr_block_rdp}"]
  #prefix_list_ids = ["pl-12c4e678"]  
  security_group_id = "${aws_security_group.main_security_group.id}"
  source_security_group_id = "${var.source_sg_id_web}"
}
