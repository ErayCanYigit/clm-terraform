terraform {
  required_version = ">= 1.3.0"

  required_providers {
    google = {
      source = "hashicorp/google"
      # Also allows 3.86.0, the version CLM pins in its own blueprints.
      version = ">= 3.86.0, < 6.0.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.1.0, < 4.0.0"
    }
  }
}

# Project and key come from CLM's Google Cloud account variables (see variables.tf).
provider "google" {
  project     = var.gcp_projectid != "" ? var.gcp_projectid : null
  credentials = var.path != "" ? file(var.path) : null
  region      = var.region
}
