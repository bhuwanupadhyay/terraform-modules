variable "domain_name" {
  type        = string
  description = "The domain name for the website."
}

variable "acm_cert_arn" {
  type        = string
  description = "The aws acm cert arn for domain name."
}

variable "bucket_name" {
  type        = string
  description = "The name of the bucket without the www. prefix. Normally domain_name."
}

variable "release_name" {
  type        = string
  description = "The name of the current release."
}

variable "common_tags" {
  description = "Common tags you want applied to all components."
}
