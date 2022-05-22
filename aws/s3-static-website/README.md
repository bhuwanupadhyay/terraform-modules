# terraform-modules/aws/s3-static-website

Terraform for hosting a secure static website hosted on AWS using S3.

## Usage

```terraform
module "s3-static-website" {
  source      = "./"
  aws_region  = "us-east-1"
  domain_name = "xyz.com"
  bucket_name = "xyz.com"
  common_tags = {
    env = "production"
  }
  acm_cert_arn = "arn:aws:acm:<aws_region>:<account_id>:certificate/<id>"
}
```


## How to Test

Now we need to upload your web files to `www.xyz.com` S3 bucket.

At the very least you need an `index.html` and a `404.html` file.

You can upload the contents of a directory to your S3 bucket by using the command:

```
aws s3 sync . s3://www.xyz.com
```

Whenever you make changes to the files in your S3 bucket you need to invalidate the Cloudfront cache.

```
aws cloudfront create-invalidation --distribution-id [DISTRIBUTION ID] --paths "/*";
```
