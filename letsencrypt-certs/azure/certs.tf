module "certs" {
  source                   = "../base"
  admin_email              = var.admin_email
  release_domain           = var.release_domain
  release_wildcards_domain = var.release_wildcards_domain
  production_ssl           = var.production_ssl
  dns_challenge_provider   = "azure"
  dns_challenge_config     = {
    AZURE_RESOURCE_GROUP  = data.azurerm_resource_group.rg.name
    AZURE_ZONE_NAME       = data.azurerm_dns_zone.dns_zone.name
    AZURE_CLIENT_ID       = var.service_principal_application_id
    AZURE_CLIENT_SECRET   = var.service_principal_password
    AZURE_TENANT_ID       = data.azurerm_subscription.primary.tenant_id
    AZURE_SUBSCRIPTION_ID = data.azurerm_subscription.primary.subscription_id
  }
}

resource "azurerm_storage_container" "container" {
  name                 = "ssl-certs"
  storage_account_name = data.azurerm_storage_account.staging_bucket.name
}

resource "azurerm_storage_blob" "private_key_pem_objects" {
  storage_container_name = azurerm_storage_container.container.name
  source_content         = module.certs.private_key
  name                   = "tls.key"
  storage_account_name   = data.azurerm_storage_account.staging_bucket.name
  type                   = "Block"
}

resource "azurerm_storage_blob" "certificate_pem_objects" {
  storage_container_name = azurerm_storage_container.container.name
  source_content         = module.certs.certificate_pem
  name                   = "tls.crt"
  storage_account_name   = data.azurerm_storage_account.staging_bucket.name
  type                   = "Block"
}

resource "azurerm_storage_blob" "issuer_pem_objects" {
  storage_container_name = azurerm_storage_container.container.name
  source_content         = module.certs.issuer_pem
  name                   = "issuer.pem"
  storage_account_name   = data.azurerm_storage_account.staging_bucket.name
  type                   = "Block"
}

resource "null_resource" "after_certificates" {
  depends_on = [
    azurerm_storage_blob.certificate_pem_objects, azurerm_storage_blob.issuer_pem_objects,
    azurerm_storage_blob.private_key_pem_objects
  ]
}