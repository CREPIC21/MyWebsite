terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">=4.30.0"
    }
  }
}

provider "google" {
  credentials = var.google_credentials_file_path
  project     = var.project_id
  region      = var.region
  zone        = var.zone
}