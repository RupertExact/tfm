resource "aws_vpc" "vpc" {
  cidr_block           = "${var.cidr}"
  enable_dns_hostnames = "${var.enable_dns_hostnames}"
  enable_dns_support   = "${var.enable_dns_support}"
  tags                 = "${merge(var.tags, map("Name", format("%s", var.name)))}"
}

resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.vpc.id}"
  tags   = "${merge(var.tags, map("Name", format("%s-igw", var.name)))}"
}

resource "aws_route_table" "public" {
  vpc_id           = "${aws_vpc.vpc.id}"
  propagating_vgws = ["${var.public_propagating_vgws}"]
  tags             = "${merge(var.tags, map("Name", format("%s-rt-pub", var.name)))}"
}

resource "aws_route" "public_internet_gateway" {
  route_table_id         = "${aws_route_table.public.id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.igw.id}"
}

resource "aws_route" "private_nat_gateway" {
  route_table_id         = "${element(aws_route_table.private.*.id, count.index)}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${element(aws_nat_gateway.natgw.*.id, count.index)}"
  count                  = "${length(var.azs) * lookup(map(var.enable_nat_gateway, 1), "true", 0)}"
}

resource "aws_route_table" "private" {
  vpc_id           = "${aws_vpc.vpc.id}"
  propagating_vgws = ["${var.private_propagating_vgws}"]
  count            = "${length(var.azs)}"
  tags             = "${merge(var.tags, map("Name", format("%s-rt-prv-%s", var.name, element(var.azs, count.index))))}"
}

resource "aws_subnet" "private" {
  vpc_id            = "${aws_vpc.vpc.id}"
  cidr_block        = "${var.private_subnets[count.index]}"
  availability_zone = "${element(var.azs, count.index)}"
  count             = "${length(var.private_subnets)}"
  tags              = "${merge(var.tags, map("Name", format("%s-sub-prv-%s", var.name, element(var.azs, count.index))), map("Tier", "private"))}"
}

resource "aws_subnet" "database" {
  vpc_id            = "${aws_vpc.vpc.id}"
  cidr_block        = "${var.database_subnets[count.index]}"
  availability_zone = "${element(var.azs, count.index)}"
  count             = "${length(var.database_subnets)}"
  tags              = "${merge(var.tags, map("Name", format("%s-db-sub-%s", var.name, element(var.azs, count.index))), map("Tier", "database"))}"
}

resource "aws_db_subnet_group" "database" {
  name        = "${var.name}-rds-subnet-group"
  description = "Database subnet groups for ${var.name}"
  subnet_ids  = ["${aws_subnet.database.*.id}"]
  tags        = "${merge(var.tags, map("Name", format("%s-db-sub-group", var.name)))}"
  count       = "${length(var.database_subnets) > 0 ? 1 : 0}"
}

resource "aws_subnet" "public" {
  vpc_id            = "${aws_vpc.vpc.id}"
  cidr_block        = "${var.public_subnets[count.index]}"
  availability_zone = "${element(var.azs, count.index)}"
  count             = "${length(var.public_subnets)}"
  tags              = "${merge(var.tags, map("Name", format("%s-sub-pub-%s", var.name, element(var.azs, count.index))), map("Tier", "public"))}"

  map_public_ip_on_launch = "${var.map_public_ip_on_launch}"
}

resource "aws_eip" "nateip" {
  vpc   = true
  count = "${length(var.azs) * lookup(map(var.enable_nat_gateway, 1), "true", 0)}"
}

resource "aws_nat_gateway" "natgw" {
  allocation_id = "${element(aws_eip.nateip.*.id, count.index)}"
  subnet_id     = "${element(aws_subnet.public.*.id, count.index)}"
  count         = "${length(var.azs) * lookup(map(var.enable_nat_gateway, 1), "true", 0)}"

  depends_on = ["aws_internet_gateway.igw"]
}

resource "aws_route_table_association" "private" {
  count          = "${length(var.private_subnets)}"
  subnet_id      = "${element(aws_subnet.private.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.private.*.id, count.index)}"
}

resource "aws_route_table_association" "database" {
  count          = "${length(var.database_subnets)}"
  subnet_id      = "${element(aws_subnet.database.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.private.*.id, count.index)}"
}

resource "aws_route_table_association" "public" {
  count          = "${length(var.public_subnets)}"
  subnet_id      = "${element(aws_subnet.public.*.id, count.index)}"
  route_table_id = "${aws_route_table.public.id}"
}

# Declare the data source
data "aws_vpc_endpoint_service" "s3" {
  service = "s3"
}

data "aws_route_table" "all" {
  vpc_id = "${aws_vpc.vpc.id}"  
}

# Create a VPC endpoint
resource "aws_vpc_endpoint" "s3_endpoint" {
  vpc_id = "${aws_vpc.vpc.id}"  
  service_name = "${data.aws_vpc_endpoint_service.s3.service_name}"
  route_table_ids  = [
      "${data.aws_route_table.all.id}"
      
      ]
}
#"${aws_route_table.public.id}"

resource "aws_default_security_group" "default_sg" {
  vpc_id = "${aws_vpc.vpc.id}"

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["${var.cidr}"]
  }

  ingress {
    protocol  = -1
    self      = true
    from_port = 0
    to_port   = 0
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = "${merge(var.tags, map("Name", format("%s", var.name,"-sg-default")))}"
  
}