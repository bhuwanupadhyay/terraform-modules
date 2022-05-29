terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.65.0"
    }
  }
  required_version = ">= 0.14"
}

provider "aws" { region = var.region }
data "aws_region" "current" {}
data "aws_caller_identity" "current" {}
data "aws_availability_zones" "available" {}


data "aws_route53_zone" "dns_zone" {
  name = var.root_domain
}

data "aws_s3_bucket" "staging_bucket" {
  bucket = var.staging_bucket_name
}
