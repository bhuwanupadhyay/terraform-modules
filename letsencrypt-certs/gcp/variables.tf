variable "release_name" {}
variable "root_domain" {}
variable "admin_email" {}
variable "release_domain" {}
variable "release_wildcards_domain" { type = set(string) }
variable "staging_bucket_name" {}
variable "region" {}
variable "production_ssl" {type = bool default = false}

variable "project_id" {}