variable "network_name" {
  default = "my-website-network"
}

variable "instance_name" {
  default = "my-website-vm"
}

variable "machine_type" {
  default = "f1-micro"
}

variable "instance_image" {
  default = "debian-cloud/debian-11"
}

variable "project_id" {
  default = "my-first-gke-project-372214"
}

variable "region" {
  default = "europe-west1"
}

variable "zone" {
  default = "europe-west1-b"
}

variable "google_credentials_file_path" {
  default = "../gcp_keys/my-first-gke-project-372214-64ee6b1be0c8.json"
}

variable "firewall_name" {
  default = "my-website-firewall"
}
