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

variable "resource_group_name" {}
variable "service_principal_application_id" {}
variable "service_principal_password" {}