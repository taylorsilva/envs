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

There is a `nginx.conf` in this repo. You should link (`ln -s`) this file to `/etc/nginx/nginx.conf` to keep this repo up to date.

```
ln -s ./envs/raspberry-pi/nginx/nginx.conf /etc/nginx/nginx.conf
```

## Let's Encrypt

Install certbot. Main website has great instructions.
https://certbot.eff.org/
