
// Output the ID of the EC2 instance created
output "peer_id" {
  value = "${aws_vpc_peering_connection.vpc_peer.id}"
}