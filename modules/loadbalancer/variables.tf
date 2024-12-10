variable "compartment_id" {
  description = "OCI compartment ID"
  type        = string
}

variable "public_subnet_id" {
  description = "Public subnet ID for the Load Balancer"
  type        = string
}

variable "ec2_ip" {
  description = "EC2 instance IP address"
  type        = string
}

variable "sg_id" {
  description = "The OCID of the security group for the load balancer"
  type        = string
}