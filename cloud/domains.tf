# TODO: import existing records
# terraform import namecheap_domain_records.taydev taydev.net

resource "namecheap_domain_records" "taydev" {
  domain = "taydev.com"
  mode = "MERGE"
  email_type = "NONE"

  record {
    hostname = "ci"
    type = "A"
    address = di
  }

  record {
    hostname = "vault"
    type = "A"
    address = digitalocean_droplet.vault.ip
  }
}
