variable "release_name" {}
variable "root_domain" {}
variable "admin_email" {}
variable "release_domain" {}
variable "release_wildcards_domain" { type = set(string) }
variable "production_ssl" {
  type = bool
  default = false
}
variable "staging_bucket_name" {}
variable "region" {}