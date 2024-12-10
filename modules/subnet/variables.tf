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

variable "availability_domain" {
  description = "OCI Availability Domain"
  type        = string
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
  default     = "10.0.0.0/24"
}


variable "public_route_table_id" {
  description = "Route table ID for the public subnet"
  type        = string
}


