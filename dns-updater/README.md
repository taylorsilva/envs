Updates a list of domains with the machines current external IP address.

Sample `config.yaml`

```yaml
domains:
- host: thebox
  domain: taydev.net

password:
```

Setup a crontab: `crontab -e`

```
*/15 * * * * /home/taylor/envs/dns-updater/dns-updater /home/taylor/envs/dns-updater/config.yml > /dev/null
```
