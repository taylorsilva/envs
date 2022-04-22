resource "digitalocean_project" "ci" {
  name        = "ci"
  description = "Resources dedicated to running concourse"
  environment = "Production"
  resources   = []
}

terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
    namecheap = {
      source = "namecheap/namecheap"
      version = "~> 2.0"
    }
  }
}

provider "digitalocean" {
  token = var.do_token
}

data "digitalocean_ssh_key" "terraform-ssh" {
  name = "terraform-ssh"
}
