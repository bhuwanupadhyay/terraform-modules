module "certs" {
  source                   = "../base"
  admin_email              = var.admin_email
  release_domain           = var.release_domain
  release_wildcards_domain = var.release_wildcards_domain
  production_ssl           = var.production_ssl
  dns_challenge_provider   = "gcloud"
  dns_challenge_config     = {
    GCE_PROJECT = data.google_client_config.current.project
  }
}

resource "google_storage_bucket_object" "private_key_pem_objects" {
  name    = "ssl-certs/tls.key"
  content = module.certs.private_key
  bucket  = data.google_storage_bucket.staging_bucket.name
}

resource "google_storage_bucket_object" "certificate_pem_objects" {
  name    = "ssl-certs/tls.crt"
  content = module.certs.certificate_pem
  bucket  = data.google_storage_bucket.staging_bucket.name
}

resource "google_storage_bucket_object" "issuer_pem_objects" {
  name    = "ssl-certs/issuer.pem"
  content = module.certs.issuer_pem
  bucket  = data.google_storage_bucket.staging_bucket.name
}

resource "null_resource" "after_certificates" {
  depends_on = [
    google_storage_bucket_object.certificate_pem_objects, google_storage_bucket_object.issuer_pem_objects,
    google_storage_bucket_object.private_key_pem_objects
  ]
}