Create a `.env` file in this directory and populate with the `GITHUB_*` client
id and secret. This file will be read by docker-compose.
The vault token can be any string you want, like a password.

To store stuff in vault:
```
sudo docker-compose exec vault sh
$ vault kv put /concourse/main/private_key value=@key
$ vault kv put /concourse/main/docker username=something password=morestring
```
