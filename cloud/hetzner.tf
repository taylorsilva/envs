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
  user_data = file("./postgres.yml")

  network {
    network_id = hcloud_network.network.id
    ip         = "10.0.1.1"
  }

  depends_on = [
    hcloud_network_subnet.network-subnet
  ]

  ssh_keys = [
    hcloud_ssh_key.taylor.id
  ]
}

resource "hcloud_server" "web-vault" {
  name        = "web-vault"
  server_type = "cx11"
  image       = "debian-11"
  location    = "fsn1"
  user_data = file("./web-vault.yml")

  network {
    network_id = hcloud_network.network.id
    ip         = "10.0.1.2"
  }

  depends_on = [
    hcloud_network_subnet.network-subnet
  ]

  ssh_keys = [
    hcloud_ssh_key.taylor.id
  ]
}

resource "hcloud_server" "worker" {
  name        = "worker"
  server_type = "cpx31"
  image       = "debian-11"
  location    = "fsn1"
  user_data = file("./worker.yml")

  network {
    network_id = hcloud_network.network.id
    ip         = "10.0.1.3"
  }

  depends_on = [
    hcloud_network_subnet.network-subnet
  ]

  ssh_keys = [
    hcloud_ssh_key.taylor.id
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

  rule {
    direction = "in"
    protocol  = "tcp"
    port      = "22"
    source_ips = [
      "198.98.125.216/32"
    ]
  }
}

resource "hcloud_firewall_attachment" "web-firewall-attach" {
  firewall_id = hcloud_firewall.web-firewall.id
  server_ids  = [hcloud_server.web-vault.id]
}

resource "hcloud_ssh_key" "taylor" {
  name       = "taylor"
  public_key = file("~/.ssh/id_rsa.pub")
}
