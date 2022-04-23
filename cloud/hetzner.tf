provider "hcloud" {
  token         = var.hcloud_token
  poll_interval = "1s"
}

resource "hcloud_network" "network" {
  name     = "network"
  ip_range = "10.0.0.0/16"
}

resource "hcloud_network_subnet" "network-subnet" {
  type         = "cloud"
  network_id   = hcloud_network.network.id
  network_zone = "eu-central"
  ip_range     = "10.0.1.0/24"
}


resource "hcloud_server" "postgres" {
  name        = "postgres"
  server_type = "cx31"
  image       = "debian-11"
  location    = "fsn1"
  # user_data   = "TODO"

  network {
    network_id = hcloud_network.network.id
  }

  depends_on = [
    hcloud_network_subnet.network-subnet
  ]
}

resource "hcloud_server" "web-vault" {
  name        = "web-vault"
  server_type = "cx11"
  image       = "debian-11"
  location    = "fsn1"
  # user_data   = "TODO"

  network {
    network_id = hcloud_network.network.id
  }

  depends_on = [
    hcloud_network_subnet.network-subnet
  ]
}

resource "hcloud_server" "worker" {
  name        = "worker"
  server_type = "cpx31"
  image       = "debian-11"
  location    = "fsn1"
  # user_data   = "TODO"

  network {
    network_id = hcloud_network.network.id
  }

  depends_on = [
    hcloud_network_subnet.network-subnet
  ]
}

resource "hcloud_firewall" "web-firewall" {
  name = "web-firewall"
  rule {
    direction = "in"
    protocol  = "tcp"
    port      = "80"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }

  rule {
    direction = "in"
    protocol  = "tcp"
    port      = "443"
    source_ips = [
      "0.0.0.0/0",
      "::/0"
    ]
  }
}

resource "hcloud_firewall_attachment" "web-firewall-attach" {
  firewall_id = hcloud_firewall.web-firewall.id
  server_ids  = [hcloud_server.web-vault.id]
}
