# Create Load Balancer
resource "oci_load_balancer_load_balancer" "lb" {
  compartment_id           = var.compartment_id
  display_name             = "my-loadbalancer"
  shape                    = "100Mbps"
  subnet_ids               = [var.public_subnet_id]
  network_security_group_ids = [var.sg_id]

}

# Create Backend Set
resource "oci_load_balancer_backend_set" "example_backend_set" {
  load_balancer_id = oci_load_balancer_load_balancer.lb.id
  name             = "example-backend-set"
  policy           = "ROUND_ROBIN" 

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

# Create Listener
resource "oci_load_balancer_listener" "example_listener" {
  load_balancer_id          = oci_load_balancer_load_balancer.lb.id
  name                      = "example-listener"
  default_backend_set_name  = oci_load_balancer_backend_set.example_backend_set.name
  port                      = 80
  protocol                  = "HTTP"
}

output "lb_id" {
  value = oci_load_balancer_load_balancer.lb.id
}

