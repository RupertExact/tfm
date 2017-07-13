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

// allow winrm from XLD Servers
resource "aws_security_group_rule" "allow_winrm" {
  type            = "ingress"
  from_port       = 5985
  to_port         = 5986
  protocol        = "tcp"
  #cidr_blocks     = ["${var.source_cidr_block_rdp}"]
  #prefix_list_ids = ["pl-12c4e678"]  
  security_group_id = "${aws_security_group.main_security_group.id}"
  source_security_group_id = "${var.source_sg_id_winrm}"
}