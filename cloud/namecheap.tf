terraform {
  required_providers {
    namecheap = {
      source = "namecheap/namecheap"
      version = ">= 2.0.0"
    }
  }
}

provider "namecheap" {
  user_name = var.nc_user
  api_user = var.nc_api_user
  api_key = var.nc_api_key
}

