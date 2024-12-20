resource "oci_compute_instance" "ec2_instance" {
  compartment_id = var.compartment_id
  availability_domain = var.availability_domain
  shape          = var.shape
  display_name   = var.ec2-name
  subnet_id      = var.private_subnet_id

  create_vnic_details {
    subnet_id = var.private_subnet_id
  }

  metadata = {
    ssh_authorized_keys = var.ssh_public_key
  }

  source_details {
    source_type = "image"
    image_id    = var.image_id
  }
}
output "instance_id" {
  value = oci_compute_instance.ec2_instance.id
}
