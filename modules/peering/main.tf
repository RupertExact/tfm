resource "aws_vpc_peering_connection" "vpc_peer" {
  peer_owner_id = "${var.peer_owner_id}"
  peer_vpc_id   = "${var.peer_vpc_id}"
  vpc_id        = "${var.vpc_id}"
  auto_accept   = "${var.auto_accept}"

  tags = "${merge(var.tags, map("Name", format("%s", var.name)))}"
}




resource "aws_route" "vpc_to_peer" {
  route_table_id            = "${var.vpc_prv_route_table_ids[count.index]}"
  destination_cidr_block    = "${var.peer_cidr}"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.vpc_peer.id}"
  count                     = "${length(var.azs)}"
}

resource "aws_route" "peer_to_vpc_0" {
  route_table_id = "rtb-df7678b8"
  #route_table_id            = "${var.peer_prv_route_table_ids[0]}"
  destination_cidr_block    = "${var.vpc_cidr}"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.vpc_peer.id}"
  #count                     = "${length(var.mgt_vpc_azs)}"
  #count = 3
}

resource "aws_route" "peer_to_vpc_1" {
    route_table_id = "rtb-3e767859"
  #route_table_id            = "${var.peer_prv_route_table_ids[1]}"
  destination_cidr_block    = "${var.vpc_cidr}"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.vpc_peer.id}"
  #count                     = "${length(var.mgt_vpc_azs)}"
  #count = 3
}

resource "aws_route" "peer_to_vpc_2" {
    route_table_id = "rtb-bc727cdb"
  #route_table_id            = "${var.peer_prv_route_table_ids[2]}"
  destination_cidr_block    = "${var.vpc_cidr}"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.vpc_peer.id}"
  #count                     = "${length(var.mgt_vpc_azs)}"
  #count = 3
}
resource "aws_route" "peer_pub_to_vpc" {
  route_table_id = "rtb-bd727cda"
  #route_table_id            = "${var.peer_pub_route_table_ids[count.index]}"
  destination_cidr_block    = "${var.vpc_cidr}"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.vpc_peer.id}"
  #count                     = "${length(var.mgt_vpc_azs)}"
  #count = 3
}