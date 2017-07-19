
variable "zone_id" {
    description = "ID of the Route 53 DNS zone"
}
variable "record_type" {
    description = "CNAME, A, etc"
}
variable "name" {
    description = "Name of the DNS record"
}
variable "ttl" {}
variable "records" {
    default = []
    description = "IP addresses or DNS names of target resource"
}