resource "oci_core_virtual_network" "vpc" {
  compartment_id = var.compartment_id
  display_name   = var.vpc_name
  cidr_block     = var.cidr_block
}

resource "oci_core_internet_gateway" "internet_gateway" {
  compartment_id = var.compartment_id
  vcn_id         = oci_core_virtual_network.vpc.id
  display_name   = var.igw_name
  enabled     = true
}
resource "oci_core_nat_gateway" "my_nat" {
  compartment_id = var.compartment_id
  vcn_id         = oci_core_virtual_network.my_vcn.id
  display_name   = "My NAT Gateway"
  route_table_id = oci_core_route_table.private_route_table.id
}
resource "oci_core_route_table" "public_route_table" {
  compartment_id = var.compartment_id
  vcn_id         = oci_core_virtual_network.vpc.id
  display_name   = var.public_route_table_name

  route_rules {
    destination = "0.0.0.0/0"
    network_entity_id = oci_core_internet_gateway.internet_gateway.id
  }
}
resource "oci_core_route_table" "private_route_table" {
  compartment_id = var.compartment_id
  vcn_id         = oci_core_virtual_network.vpc.id
  display_name   = var.private_route_table_name
  route_rules {
    destination = "0.0.0.0/0"
    network_entity_id = oci_core_nat_gateway.my_nat.id
  }
}

output "vpc_id" {
  value = oci_core_virtual_network.vpc.id
}

output "internet_gateway_id" {
  value = oci_core_internet_gateway.internet_gateway.id
}

output "public_route_table_id" {
  value = oci_core_route_table.public_route_table.id
}

output "private_route_table_id" {
  value = oci_core_route_table.private_route_table.id
}

resource "oci_core_security_list" "lb_security_list" {
  compartment_id = var.compartment_id
  display_name   = "lb-security-list"

  ingress_security_rules {
    protocol = "6" # TCP
    source   = "0.0.0.0/0"

    tcp_options {
      min = 80
      max = 80
    }
  }

  ingress_security_rules {
    protocol = "6" # TCP
    source   = "0.0.0.0/0"

    tcp_options {
      min = 443
      max = 443
    }
  }

  egress_security_rules {
    protocol = "6" # TCP
    destination = oci_core_security_list.private_ec2_security_list.cidr_block

    tcp_options {
      min = 80
      max = 443
    }
  }
}

resource "oci_core_security_list" "private_ec2_security_list" {
  compartment_id =var.compartment_id
  display_name   = "private-ec2-security-list"

  ingress_security_rules {
    protocol = "6" # TCP
    source   = oci_core_security_list.lb_security_list.cidr_block

    tcp_options {
      min = 80
      max = 443
    }
  }

  egress_security_rules {
    protocol = "-1" # All Protocols
    destination = "0.0.0.0/0"
  }
}

output "lb_security_list_id" {
  value = oci_core_security_list.lb_security_list.id
}

output "private_ec2_security_list_id" {
  value = oci_core_security_list.private_ec2_security_list.id
}