resource "digitalocean_database_cluster" "ci_db_cluster" {
  name                 = "ci-db-cluster"
  engine               = "pg"
  version              = "14"
  size                 = "db-s-1vcpu-1gb"
  region               = "tor1"
  node_count           = 1
  private_network_uuid = digitalocean_vpc.ci.id
}

resource "digitalocean_database_db" "concourse-db" {
  cluster_id = digitalocean_database_cluster.ci_db_cluster.id
  name       = "concourse"
}

resource "digitalocean_database_db" "vault-db" {
  cluster_id = digitalocean_database_cluster.ci_db_cluster.id
  name       = "vault"
}
