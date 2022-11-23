resource "google_compute_instance" "http_server" {
  zone         = var.zone
  name         = "${var.prefix}-apache2-instance"
  machine_type = "f1-micro"

  metadata_startup_script = "sudo apt-get update && sudo apt-get install apache2 -y && echo '<html><body><h1>Environment: ${var.subnet}</h1></body></html>' | sudo tee /var/www/html/index.html"

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

  tags = ["http-server"]
}

# Bootstrapping Script
data "template_file" "windows-metadata" {
template = <<EOF
# Install IIS
Install-WindowsFeature -name Web-Server -IncludeManagementTools;
EOF
}

resource "google_compute_instance" "windows_http_server" {
  zone         = var.zone
  name         = "${var.prefix}-windows-instance"
  machine_type = "n2-standard-2"

 metadata = {
    sysprep-specialize-script-ps1 = data.template_file.windows-metadata.rendered
  }

  boot_disk {
    initialize_params {
      image = "windows-cloud/windows-2012-r2"
    }
  }

  network_interface {
    subnetwork = var.subnet
  }

  shielded_instance_config {
    enable_secure_boot = true
  }

  tags = ["http-server"]
}