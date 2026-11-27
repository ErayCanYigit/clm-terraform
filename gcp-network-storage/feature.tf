# CLM writes its own feature.tf (google pinned to 3.86.0) into the work folder only
# when the folder has none. Shipping this file lets us choose the provider versions.
terraform {
  required_version = ">= 1.3.0"

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 6.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.1.0, < 4.0.0"
    }
  }
}
