
resource "google_compute_firewall" "http_https_inbound" {
  name    = "${var.prefix}-allow-http-https-inbound"
  network = var.vpc_name

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  allow {
    protocol = "icmp"
  }

  source_ranges = ["76.67.49.250/32", "10.1.0.0/24"]
  target_tags   = ["http-server"]
}

resource "google_compute_firewall" "iap_for_tcp_forwarding" {
  name    = "${var.prefix}-allow-iap"
  network = var.vpc_name

  allow {
    protocol = "tcp"
    ports    = ["22", "3389"]
  }

  source_ranges = ["35.235.240.0/20"]
}
