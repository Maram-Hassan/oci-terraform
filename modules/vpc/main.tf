resource "oci_core_virtual_network" "vpc" {
  compartment_id = var.compartment_id
  display_name   = var.vpc_name
  cidr_block     = var.cidr_block
}

resource "oci_core_internet_gateway" "internet_gateway" {
  compartment_id = var.compartment_id
  vcn_id         = oci_core_virtual_network.vpc.id
  display_name   = var.igw_name
  is_enabled     = true
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

output "vpc_id" {
  value = oci_core_virtual_network.vpc.id
}

output "internet_gateway_id" {
  value = oci_core_internet_gateway.internet_gateway.id
}

output "public_route_table_id" {
  value = oci_core_route_table.public_route_table.id
}


resource "oci_core_network_security_group" "security_group" {
  compartment_id = var.compartment_id
  vcn_id         = oci_virtual_network_vcn.vpc.id
  display_name   = var.sg_name
}


# Security group rules for Load Balancer
resource "oci_core_network_security_group_security_rule" "allow_http" {
  network_security_group_id = oci_core_network_security_group.security_group.id
  direction                 = "INGRESS"
  protocol                  = "6" # TCP
  source_type               = "0" # CIDR
  stateless                 = true  
  tcp_options {
    destination_port_range {
      min = 80
      max = 80
    }
  }
  source = "0.0.0.0/0"
}

resource "oci_core_network_security_group_security_rule" "allow_https" {
  network_security_group_id = oci_core_network_security_group.security_group.id
  direction                 = "INGRESS"
  protocol                  = "6" # TCP
  source_type               = "0" # CIDR
  stateless                 = true 
  tcp_options {
    destination_port_range {
      min = 443
      max = 443
    }
  }
  source = "0.0.0.0/0"
}


output "sg_id" {
  value = oci_core_network_security_group.security_group.id
}


resource "oci_core_network_security_group" "security_group_instance" {
  compartment_id = var.compartment_id
  vcn_id         = oci_virtual_network_vcn.vpc.id
  display_name   = var.sg_name
}


# Security group rules for Load Balancer
resource "oci_core_network_security_group_security_rule" "allow_http_instance" {
  network_security_group_id = oci_core_network_security_group.security_group.id
  direction                 = "INGRESS"
  protocol                  = "6" # TCP
  source_type               = "0" # CIDR
  stateless                 = true 
  tcp_options {
    destination_port_range {
      min = 80
      max = 80
    }
  }
  source = var.lb_id
}

resource "oci_core_network_security_group_security_rule" "allow_https_instance" {
  network_security_group_id = oci_core_network_security_group.security_group.id
  direction                 = "INGRESS"
  protocol                  = "6" # TCP
  source_type               = "0" # CIDR
    stateless                 = true 
  tcp_options {
    destination_port_range {
      min = 443
      max = 443
    }
  }
  source = var.lb_id
}

resource "oci_core_network_security_group_security_rule" "allow_ssh_instance" {
  network_security_group_id = oci_core_network_security_group.security_group.id
  direction                 = "INGRESS"
  protocol                  = "6" # TCP
  source_type               = "0" # CIDR
    stateless                 = true 
  tcp_options {
    destination_port_range {
      min = 22
      max = 22
    }
  }
  source = var.lb_id
}
output "sg_id_instance" {
  value = oci_core_network_security_group.security_group.id
}