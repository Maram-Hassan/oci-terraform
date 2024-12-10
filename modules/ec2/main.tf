resource "oci_compute_instance" "ec2_instance" {
  compartment_id = var.compartment_id
  availability_domain = var.availability_domain
  shape          = var.shape
  display_name   = var.ec2-name
  subnet_id      = var.public_subnet_id
  network_security_group_ids = [var.sg_sg_id_instanceid]

  create_vnic_details {
    subnet_id = var.public_subnet_id
    assign_public_ip = true
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
  value = oci_core_instance.ec2_instance.id
}
