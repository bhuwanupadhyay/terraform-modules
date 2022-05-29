provider "acme" {
  server_url = var.production_ssl ? "https://acme-v02.api.letsencrypt.org/directory" : "https://acme-staging-v02.api.letsencrypt.org/directory"
}

variable "production_ssl" { type = bool default = false }
variable "admin_email" {}
variable "release_domain" {}
variable "release_wildcards_domain" { type = set(string) }
variable "dns_challenge_provider" {}
variable "dns_challenge_config" {}

resource "tls_private_key" "private_key" {
  algorithm = "RSA"
}

resource "acme_registration" "registration" {
  account_key_pem = tls_private_key.private_key.private_key_pem
  email_address   = var.admin_email
}

resource "acme_certificate" "certificate" {
  account_key_pem           = acme_registration.registration.account_key_pem
  common_name               = var.release_domain
  subject_alternative_names = var.release_wildcards_domain

  dns_challenge {
    provider = var.dns_challenge_provider
    config   = var.dns_challenge_config
  }

  depends_on = [acme_registration.registration]
}

output "private_key" {
  value = acme_certificate.certificate.private_key_pem
}

output "certificate_pem" {
  value = acme_certificate.certificate.certificate_pem
}
output "issuer_pem" {
  value = acme_certificate.certificate.issuer_pem
}