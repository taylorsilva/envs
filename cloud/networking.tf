resource "digitalocean_vpc" "ci" {
  name     = "ci-network"
  region   = "tor3"
  ip_range = "10.10.10.0/24"
}

resource "digitalocean_certificate" "ci" {
  name    = "ci-cert"
  type    = "lets_encrypt"
  domains = ["ci.taydev.net"]
}

resource "digitalocean_certificate" "vault" {
  name    = "vault-cert"
  type    = "lets_encrypt"
  domains = ["vault.taydev.net"]
}
