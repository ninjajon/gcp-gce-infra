resource "google_compute_instance" "bastion" {
  zone         = var.zone
  name         = "${var.prefix}-bastion"
  machine_type = "f1-micro"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    subnetwork = var.subnet
  }

  shielded_instance_config {
    enable_secure_boot = true
  }
}
