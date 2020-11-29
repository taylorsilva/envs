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
sudo ln ~/envs/raspberry-pi/nginx/thebox.taydev.net /etc/nginx/sites-available/thebox.taydev.net
sudo ln ~/envs/raspberry-pi/nginx/dnd.taydev.net /etc/nginx/sites-available/dnd.taydev.net
```

You'll need to then create a symbolic link to enable the site:

```
sudo ln -s /etc/nginx/sites-available/thebox.taydev.net /etc/nginx/sites-enabled/thebox.taydev.net
sudo ln -s /etc/nginx/sites-available/dnd.taydev.net /etc/nginx/sites-enabled/dnd.taydev.net
```

After changing configs you should restart nginx.

## Let's Encrypt

Install certbot. Main website has great instructions. You let it update the
nginx config for you. You can see the jellyfin.conf for where the certs are
located. certbot should set the system up to renew the certs automatically.
https://certbot.eff.org/
