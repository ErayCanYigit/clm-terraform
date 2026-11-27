# Random suffix: the same catalog item can be requested many times without name clashes.
resource "random_id" "suffix" {
  byte_length = 3
}

locals {
  name = "${var.name_prefix}-${random_id.suffix.hex}"
}

# --- Network ---

resource "google_compute_network" "vpc" {
  name                    = "${local.name}-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
  name                     = "${local.name}-subnet"
  region                   = var.region
  network                  = google_compute_network.vpc.id
  ip_cidr_range            = var.subnet_cidr
  private_ip_google_access = true
}

# SSH and ping from inside the subnet and from Google IAP.
resource "google_compute_firewall" "allow_ssh_icmp" {
  name          = "${local.name}-allow-ssh-icmp"
  network       = google_compute_network.vpc.id
  source_ranges = [var.subnet_cidr, "35.235.240.0/20"]

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  allow {
    protocol = "icmp"
  }
}

# --- Storage ---

resource "google_storage_bucket" "bucket" {
  name                        = "${local.name}-bucket"
  location                    = upper(var.region)
  force_destroy               = true
  uniform_bucket_level_access = true

  labels = {
    created-by = "bigfix-clm"
  }
}
