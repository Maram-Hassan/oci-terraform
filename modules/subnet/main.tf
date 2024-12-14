resource "oci_core_subnet" "public_subnet" {
  compartment_id = var.compartment_id
  vcn_id         = var.vcn_id
  display_name   = var.public-subnet-name
  cidr_block     = var.public_subnet_cidr
  availability_domain = var.availability_domain
  route_table_id = var.public_route_table_id
  security_list_ids = [var.lb_security_list_id]
}

resource "oci_core_subnet" "private_subnet" {
  compartment_id = var.compartment_id
  vcn_id         = var.vcn_id
  display_name   = var.private-subnet-name
  cidr_block     = var.private_subnet_cidr
  availability_domain = var.availability_domain
  route_table_id = var.private_route_table_id
  prohibit_public_ip_on_vnic = true
  security_list_ids = [var.private_ec2_security_list_id]

}


output "public_subnet_id" {
  value = oci_core_subnet.public_subnet.id
}

output "private_subnet_id" {
  value = oci_core_subnet.private_subnet.id
}
