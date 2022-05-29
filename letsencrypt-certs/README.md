# Letsencrypt Certs

This module will generate ssl certificates for different cloud provider with their dns challenge using Letsencrypt. 
Also, it stores generated certificates in defined bucket in that cloud provider under `ssl-certs` folder. 

## Usage

```terraform
module "certs" {
  source       = "git::https://github.com/bhuwanupadhyay/terraform-modules.git//letsencrypt-certs/aws?ref=main"
  admin_email              = "<certs_admin_email>"
  region                   = "<cloud_region>"
  root_domain              = "<cloud_dns_root_domain>"
  release_domain           = "<release_app_domain>"
  release_wildcards_domain = [
    "*.example1.<release_app_domain>",
    "*.example2.<release_app_domain>",
    "*.xyz.example3.<release_app_domain>",
  ]
  staging_bucket_name = "<bucket_to_store_certificates>"
  release_name        = "<certs_release_name>"
  production_ssl      = true
}
```

### Hints 
- `production_ssl = true` will use production server of letsencrypt. (https://acme-v02.api.letsencrypt.org/directory)
- `production_ssl = false` will use staging server of letsencrypt. (https://acme-staging-v02.api.letsencrypt.org/directory)

### Initialize module

```bash
terraform init
```


### Apply module

```bash
terraform apply
```


### Download Certs

```bash
export bucket_to_store_certificates=<bucket_to_store_certificates>
# AWS
aws s3 cp s3://$bucket_to_store_certificates/ssl-certs/ ./build/ssl-certs/ --recursive

# GCP
gsutil rsync -d -r gs://$bucket_to_store_certificates/ssl-certs/ ./build/ssl-certs/

# AZURE
az storage file download -s $bucket_to_store_certificates -p issuer.pem --dest ./build/ssl-certs/issuer.pem
az storage file download -s $bucket_to_store_certificates -p tls.crt --dest ./build/ssl-certs/tls.crt
az storage file download -s $bucket_to_store_certificates -p tls.key --dest ./build/ssl-certs/tls.key
```

### Destroy module

```bash
terraform apply
```