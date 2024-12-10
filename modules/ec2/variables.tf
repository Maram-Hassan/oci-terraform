variable "compartment_id" {
  description = "OCI compartment ID"
  type        = string
}

variable "availability_domain" {
  description = "OCI Availability Domain"
  type        = string
}

variable "public_subnet_id" {
  description = "public subnet ID"
  type        = string
}

variable "shape" {
  description = "Shape for the EC2 instance"
  type        = string
  default     = "VM.Standard2.1"
}

variable "ssh_public_key" {
  description = "SSH public key for accessing the EC2 instance"
  type        = string
}

variable "image_id" {
  description = "Image ID for the EC2 instance"
  type        = string
}

variable "ec2-name" {
  description = "name for the EC2 instance"
  type        = string
  default     = "my-ec2"

}

variable "sg_id_instance" {
  description = "The OCID of the security group for the EC2 instance"
  type        = string
}