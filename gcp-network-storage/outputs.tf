output "vpc" {
  value = google_compute_network.vpc.name
}

output "subnet" {
  value = google_compute_subnetwork.subnet.name
}

output "firewall" {
  value = google_compute_firewall.allow_ssh_icmp.name
}

output "bucket" {
  value = google_storage_bucket.bucket.name
}
