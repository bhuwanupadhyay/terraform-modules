module "certs" {
  source                   = "../base"
  admin_email              = var.admin_email
  release_domain           = var.release_domain
  release_wildcards_domain = var.release_wildcards_domain
  dns_challenge_provider   = "route53"
  dns_challenge_config     = {
    AWS_HOSTED_ZONE_ID = data.aws_route53_zone.dns_zone.zone_id
  }
}

resource "aws_s3_bucket_object" "private_key_pem_objects" {
  bucket  = var.staging_bucket_name
  key     = "ssl-certs/tls.key"
  content = module.certs.private_key
}

resource "aws_s3_bucket_object" "certificate_pem_objects" {
  bucket  = var.staging_bucket_name
  key     = "ssl-certs/tls.crt"
  content = module.certs.certificate_pem
}

resource "aws_s3_bucket_object" "issuer_pem_objects" {
  bucket  = var.staging_bucket_name
  key     = "ssl-certs/issuer.pem"
  content = module.certs.issuer_pem
}

resource "null_resource" "after_certificates" {
  depends_on = [
    aws_s3_bucket_object.certificate_pem_objects, aws_s3_bucket_object.issuer_pem_objects,
    aws_s3_bucket_object.private_key_pem_objects
  ]
}