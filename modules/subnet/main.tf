resource "oci_core_subnet" "public_subnet" {
  compartment_id = var.compartment_id
  vcn_id         = var.vcn_id
  display_name   = var.public-subnet-name
  cidr_block     = var.public_subnet_cidr
  availability_domain = var.availability_domain
  route_table_id = var.public_route_table_id
}

output "public_subnet_id" {
  value = oci_core_subnet.public_subnet.id
}
