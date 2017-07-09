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

// allows traffic for TCP 80 (HTTP) - should be load balancer only
resource "aws_security_group_rule" "allow_http" {
  type            = "ingress"
  from_port       = 80
  to_port         = 80
  protocol        = "tcp"
  cidr_blocks     = ["${var.source_cidr_block_http}"]
  #prefix_list_ids = ["pl-12c4e678"]  
  security_group_id = "${aws_security_group.main_security_group.id}"
  #source_security_group_id = ""
}
// allows traffic for TCP 443 (HTTPS) - should be load balancer only
resource "aws_security_group_rule" "allow_https" {
  type            = "ingress"
  from_port       = 443
  to_port         = 443
  protocol        = "tcp"
  cidr_blocks     = ["${var.source_cidr_block_https}"]
  #prefix_list_ids = ["pl-12c4e678"]  
  security_group_id = "${aws_security_group.main_security_group.id}"
  #source_security_group_id = ""
}