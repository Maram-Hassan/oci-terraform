resource "oci_load_balancer_load_balancer" "lb" {
  compartment_id = var.compartment_id
  display_name   = "my-loadbalancer"
  shape          = "100Mbps"
  subnet_ids     = [var.public_subnet_id]
  network_security_group_ids = [var.sg_id]


  backend_sets {
    name = "example-backend-set"

    backends {
      ip_address = var.ec2_ip
      port       = 80
    }

    health_checker {
      protocol = "HTTP"
      port     = 80
      url_path = "/"
    }
  }

  listener {
    name           = "example-listener"
    default_backend_set_name = "example-backend-set"
    port           = 80
    protocol       = "HTTP"
  }
}
output "lb_id" {
  value = oci_load_balancer_load_balancer.lb.id
}

