module "vpc" {
  source        = "./vpc"
  compartment_id = var.compartment_id
  vpc_name       = "my-vpc"
  cidr_block     = "10.0.0.0/16"
  igw_name       = "my-igw"
  public_route_table_name = "public-route-table"
 }

module "subnet" {
  source             = "./subnet"
  compartment_id     = var.compartment_id
  vcn_id             = module.vpc.vpc_id
  availability_domain = var.availability_domain
  public_subnet_cidr = "10.0.0.0/24"
  public_route_table_id = module.vpc.public_route_table_id
  public-subnet-name   = "public-subnet"
}

module "loadbalancer" {
  source           = "./loadbalancer"
  compartment_id   = var.compartment_id
  public_subnet_id = module.subnet.public_subnet_id
  ec2_ip           = module.ec2.instance_id
  sg_id            = module.vpc.sg_id
}

module "ec2" {
  source            = "./ec2"
  compartment_id    = var.compartment_id
  availability_domain = var.availability_domain
  public_subnet_id = module.subnet.public_subnet_id
  shape             = "VM.Standard2.1"
  ssh_public_key    = var.ssh_public_key
  image_id          = "ocid1.image.oc1..xxxxxxxxxxxxx"
  sg_id_instance = module.vpc.sg_id_instance
}
