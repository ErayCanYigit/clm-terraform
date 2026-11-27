# --- Google Cloud account values from CLM (same names CLM uses in its own blueprint files) ---

variable "gcp_projectid" {
  type    = string
  default = ""
}

variable "path" {
  description = "Path of the service account key file on the CLM server"
  type        = string
  default     = ""
}

variable "googleregion" {
  type    = string
  default = ""
}

variable "gcp_type" {
  type    = string
  default = ""
}

variable "gcp_client_email" {
  type    = string
  default = ""
}

variable "gcp_private_key_id" {
  type      = string
  default   = ""
  sensitive = true
}

variable "gcp_private_key" {
  type      = string
  default   = ""
  sensitive = true
}

# --- Inputs for the request form ---

variable "name_prefix" {
  description = "Name prefix for the resources"
  type        = string
  default     = "clm-git"

  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{1,29}[a-z0-9]$", var.name_prefix))
    error_message = "Use 3-31 characters: lowercase letters, digits and hyphens, starting with a letter."
  }
}

variable "region" {
  description = "Google Cloud region"
  type        = string
  default     = "europe-west1"
}

variable "subnet_cidr" {
  description = "IP range of the subnet"
  type        = string
  default     = "10.20.0.0/24"
}
