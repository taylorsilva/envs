terraform {
  required_providers {
    hcloud = {
      source  = "hetznercloud/hcloud"
      version = "~> 1.33"
    }
    namecheap = {
      source  = "namecheap/namecheap"
      version = "~> 2.0"
    }
  }
}

