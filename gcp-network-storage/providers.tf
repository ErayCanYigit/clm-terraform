# No terraform { required_providers } block here: at deploy time CLM writes its
# own feature.tf with that block, and a module may have only one.

locals {
  # CLM also writes the Google Cloud account key into the work folder as a JSON
  # file. Use that file when CLM does not pass var.path.
  key_files = [
    for f in fileset(path.module, "*.json") : "${path.module}/${f}"
    if try(jsondecode(file("${path.module}/${f}")).private_key, "") != ""
  ]
  key_file = var.path != "" ? var.path : try(local.key_files[0], "")

  # First non-empty one: CLM's project variable, the project in the key file, var.project.
  project_id = try(coalesce(var.gcp_projectid, try(jsondecode(file(local.key_file)).project_id, ""), var.project), null)
}

# Project and key come from CLM's Google Cloud account variables (see variables.tf).
provider "google" {
  project     = local.project_id
  credentials = local.key_file != "" ? file(local.key_file) : null
  region      = var.region
}
