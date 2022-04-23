provider "namecheap" {
  user_name = var.nc_user
  api_user  = var.nc_api_user
  api_key   = var.nc_api_key
}

resource "namecheap_domain_records" "taydev-net" {
  domain = "taydev.net"
  mode   = "MERGE"

  record {
    hostname = "ci"
    type     = "A"
    address  = hcloud_server.web-vault.ipv4_address
  }
}
