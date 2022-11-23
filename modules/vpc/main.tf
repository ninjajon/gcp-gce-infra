resource "google_compute_network" "vpc_network" {
  name                    = "${var.prefix}-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "private_subnet" {
  name          = "${var.prefix}-private-subnet"
  ip_cidr_range = var.private_subnet_cidr
  region        = "us-central1"
  network       = google_compute_network.vpc_network.id
}

resource "google_compute_subnetwork" "public_subnet" {
  name          = "${var.prefix}-public-subnet"
  ip_cidr_range = var.public_subnet_cidr
  region        = "us-central1"
  network       = google_compute_network.vpc_network.id
}
