// Security Group Resource for Module
resource "aws_security_group" "main_security_group" {
  name        = "${var.name}"
  description = "Security Group ${var.name}"
  vpc_id      = "${var.vpc_id}"
  tags                 = "${merge(var.tags, map("Name", format("%s", var.name)))}"

  // allows traffic for TCP 22 (SSH)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.source_cidr_block}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}