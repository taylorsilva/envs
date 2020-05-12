# nginx setup

## Installing

nginx will be installed as a service under `/etc/init.d`

```
sudo apt install nginx
```

## Managing the service

use `/etc/init.d/nginx` or `systemctl`

To start:
```
$ sudo /etc/init.d/nginx start
or
$ sudo systemctl start nginx
```

To restart:
```
$ sudo /etc/init.d/nginx reload
or
$ sudo systemctl restart nginx
```

Other `systemctl` commands include:
* `stop`
* `restart`
* `status`
* `show`

## Configuring nginx

All nginx configuration is under `/etc/nginx/`. The main config file is `nginx.conf`.

There is a `jellyfin.conf` in this repo. You should create a hard link (`ln`)
this file to `/etc/nginx/conf.d/jellyfin.conf` to keep this repo and deployment
up to date.

```
ln ~/envs/raspberry-pi/nginx/jellyfin.conf /etc/nginx/conf.d/jellyfin.conf
```

## Let's Encrypt

Install certbot. Main website has great instructions. You did the "just get a certificate" option instead of having certbot install the certs for you.
https://certbot.eff.org/
