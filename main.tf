module "vpc" {
  source = "./modules/vpc"
  providers = {
    google = google.target
  }
  prefix              = var.prefix
  private_subnet_cidr = "10.0.0.0/24"
  public_subnet_cidr  = "10.1.0.0/24"
}

module "http_server" {
  source = "./modules/http_server"
  providers = {
    google = google.target
  }
  prefix = var.prefix
  zone   = "${var.region}-a"
  subnet = module.vpc.private_subnet_name
}

module "bastion" {
  source = "./modules/bastion"
  providers = {
    google = google.target
  }
  prefix = var.prefix
  zone   = "${var.region}-a"
  subnet = module.vpc.public_subnet_name
}

module "firewall" {
  source = "./modules/firewall"
  providers = {
    google = google.target
  }
  prefix   = var.prefix
  vpc_name = module.vpc.vpc_name
}

module "nat" {
  source = "./modules/nat"
  providers = {
    google = google.target
  }
  prefix   = var.prefix
  vpc_name = module.vpc.vpc_name
  region   = var.region
}
