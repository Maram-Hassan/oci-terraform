module "vpc" {
  source        = "./vpc"
  compartment_id = var.compartment_id
  vpc_name       = "my-vpc"
  cidr_block     = "10.0.0.0/16"
  igw_name       = "my-igw"
  public_route_table_name = "public-route-table"
  private_route_table_name = "private-route-table"
 }

module "subnets" {
  source = "./subnets" 
  compartment_id        = var.compartment_id
  vcn_id                = var.vcn_id
  public_subnet_name    = "public-subnet"
  public_subnet_cidr    = "10.0.0.0/24"
  private_subnet_name   = "private-subnet"
  private_subnet_cidr   = "10.0.1.0/24"
  availability_domain   = var.availability_domain
  public_route_table_id = module.vpc.public_route_table_id
  private_route_table_id = module.vpc.private_route_table_id
  lb_security_list_id = [module.vpc.lb_security_list_id]
  private_ec2_security_list_id = [module.vpc.private_ec2_security_list_id]
}


module "loadbalancer" {
  source           = "./loadbalancer"
  compartment_id   = var.compartment_id
  public_subnet_id = module.subnet.public_subnet_id
  ec2_ip           = module.ec2.instance_id
}

module "ec2" {
  source            = "./ec2"
  compartment_id    = var.compartment_id
  availability_domain = var.availability_domain
  private_subnet_id = module.subnet.private_subnet_id
  shape             = "VM.Standard2.1"
  ssh_public_key    = var.ssh_public_key
  image_id          = "ocid1.image.oc1..xxxxxxxxxxxxx"
}
