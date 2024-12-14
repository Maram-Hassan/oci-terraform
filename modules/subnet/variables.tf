variable "compartment_id" {
  description = "OCI compartment ID"
  type        = string
}

variable "vcn_id" {
  description = "VCN ID"
  type        = string
}
variable "public-subnet-name" {
  description = "Name for the public-subnet"
  type        = string
  default     = "public-subnet"
}
variable "private-subnet-name" {
  description = "Name for the private-subnet"
  type        = string
  default     = "private-subnet"
}
variable "availability_domain" {
  description = "OCI Availability Domain"
  type        = string
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
  default     = "10.0.0.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR block for the private subnet"
  type        = string
  default     = "10.0.1.0/24"
}
variable "public_route_table_id" {
  description = "Route table ID for the public subnet"
  type        = string
}


variable "private_route_table_id" {
  description = "Route table ID for the public subnet"
  type        = string
}


variable "private_ec2_security_list_id" {
  description = "private ec2 security list ID for the private subnet"
  type        = string
}
variable "lb_security_list_id" {
  description = "lb security list id ID for the public subnet"
  type        = string
}
