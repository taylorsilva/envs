Create a `.env` file in this directory and populate with the `GITHUB_*` client
id and secret. This file will be read by docker-compose.
The vault token can be any string you want, like a password.

Setting Up Vault:
```
sudo docker-compose exec vault sh
$ vault login token=thattoken
$ vault secrets enable -path=/concourse kv
```

To store stuff in vault:
```
$ vault kv put /concourse/main/private_key value=@key
$ vault kv put /concourse/main/docker username=something password=morestring
```
