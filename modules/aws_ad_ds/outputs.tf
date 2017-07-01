
// Output the ID of the EC2 instance created
output "ad_ds_id" {
  value = "${aws_directory_service_directory.ad_ds.id}"
}

// Outputs a list of dns servers ip addresses
output "dns_svr_ips" {
  value = ["${aws_directory_service_directory.ad_ds.dns_ip_addresses}" ]
}