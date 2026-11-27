# No terraform { required_providers } block here: at deploy time CLM writes its
# own feature.tf with that block, and a module may have only one.

# Project and key come from CLM's Google Cloud account variables (see variables.tf).
provider "google" {
  project     = var.gcp_projectid != "" ? var.gcp_projectid : null
  credentials = var.path != "" ? file(var.path) : null
  region      = var.region
}
