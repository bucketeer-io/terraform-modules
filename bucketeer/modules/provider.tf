terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.48.0"
    }
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "~> 4.48.0"
    }
  }
}

provider "google" {
  # credentials = file(var.gcp_credentials)
  project = var.gcp_project
  region  = var.gcp_region
}

provider "google-beta" {
  # credentials = file(var.gcp_credentials)
  project = var.gcp_project
  region  = var.gcp_region
}
