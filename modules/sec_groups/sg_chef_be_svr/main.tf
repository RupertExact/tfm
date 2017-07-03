// Security Group Resource for Module
resource "aws_security_group" "main_security_group" {
  name        = "${var.name}"
  description = "Security Group ${var.name}"
  vpc_id      = "${var.vpc_id}"
  tags = "${merge(var.tags, map("Name", format("%s", var.name)))}"

  // allows traffic for TCP 22 (SSH)
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.source_cidr_block_ssh}"]
  }
  
  // allows ETCD trafic from Chef FE Servers and between Chef BE servers
  ingress {
    from_port   = 2379
    to_port     = 2380
    protocol    = "tcp"
    cidr_blocks = ["${var.source_cidr_block_etcd}"]
  }
  // allows postgresql traffic from Chef FE servers and between Chef BE servers
  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["${var.source_cidr_block_pgsql}"]
  }
  // allows leaderl traffic from Chef FE servers and between Chef BE servers
  ingress {
    from_port   = 7331
    to_port     = 7331
    protocol    = "tcp"
    cidr_blocks = ["${var.source_cidr_block_ldrl}"]
  }
  // allows elasticsearch traffic from Chef FE servers and between Chef BE servers
  ingress {
    from_port   = 9200
    to_port     = 9400
    protocol    = "tcp"
    cidr_blocks = ["${var.source_cidr_block_els}"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}





