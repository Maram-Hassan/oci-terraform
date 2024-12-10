variable "compartment_id" {
  description = "OCI compartment ID"
  type        = string
}

variable "vpc_name" {
  description = "Name for the VPC"
  type        = string
  default     = "my-vpc"
}
variable "igw_name" {
  description = "Name for the igw"
  type        = string
  default     = "my-igw"
}
variable "public_route_table_name" {
  description = "Name for the public_route_table"
  type        = string
  default     = "public-route-table"
}

variable "cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "sg_name" {
  description = "The name of the security group"
  type        = string
}