resource "azurerm_storage_account" "web" {
  name                      = local.unique_id_sanitized
  resource_group_name       = azurerm_resource_group.rg.name
  location                  = azurerm_resource_group.rg.location
  account_tier              = "Standard"
  account_replication_type  = "LRS"
  allow_blob_public_access  = true # Be aware that this is not always what you want
  enable_https_traffic_only = false
  min_tls_version           = "TLS1_2"

  custom_domain {
    name          = local.web_hostname
    use_subdomain = false
  }

  static_website {
    index_document = "index.html"
  }

  depends_on = [azurerm_dns_cname_record.www]
}

// Hacks
data "external" "frontend-zip-etag" {
  program = ["${path.module}/hacks/etag.sh", var.frontend_zip]
}

resource "null_resource" "frontend-payload" {
  triggers = {
    zip_file_etag = data.external.frontend-zip-etag.result["etag"]
  }

  provisioner "local-exec" {
    command = "${path.module}/hacks/frontend.sh ${var.frontend_zip} http://${azurerm_container_group.backend.fqdn}:8080/api ${azurerm_storage_account.web.name} ${azurerm_storage_account.web.primary_access_key}"
  }
}
