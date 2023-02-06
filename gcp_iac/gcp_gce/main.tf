resource "google_compute_network" "vpc_network" {
  name                    = var.network_name
  auto_create_subnetworks = "true"
}

resource "google_compute_instance" "my_website_vm" {
  name         = var.instance_name
  machine_type = var.machine_type
  tags         = ["rules"]

  boot_disk {
    initialize_params {
      image = var.instance_image
    }
  }
  allow_stopping_for_update = true

  
  metadata_startup_script = file("startup.sh")
  

  network_interface {
    network = google_compute_network.vpc_network.name
    access_config {
    }
  }
}

resource "google_compute_firewall" "rules" {
  name          = var.firewall_name
  project       = var.project_id
  network       = google_compute_network.vpc_network.name
  description   = "Creates firewall rule targeting tagged instances"
  source_ranges = ["0.0.0.0/0"]
  target_tags = ["rules"]

    allow {
    protocol = "tcp"
    ports    = ["80", "8080"]
  }

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  allow {
    protocol = "tcp"
    ports    = ["443"]
  }

}