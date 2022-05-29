terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.10.0"
    }
  }
  required_version = ">= 0.14"
  backend "gcs" {}
}

provider "google" {
  project = var.project_id
  region  = var.region
}

data "google_dns_managed_zone" "dns_zone" {
  name = replace(var.root_domain, ".", "-")
}

data "google_storage_bucket" "staging_bucket" {
  name = var.staging_bucket_name
}

data "google_client_config" "current" {}