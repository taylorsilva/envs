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

All nginx configuration is under `/etc/nginx/`. The main config file is
`nginx.conf`. Nothing has been modified in that file.

There are files in this folder with domains as the file name. You should create
hard links (`ln`) to these files in `/etc/nginx/sites-available/<file-name>`.

```
sudo ln ~/envs/alb/nginx/thebox.taydev.net /etc/nginx/sites-available/thebox.taydev.net
sudo ln ~/envs/alb/nginx/dnd.taydev.net /etc/nginx/sites-available/dnd.taydev.net
```

You'll need to then create a symbolic link (`ln -s`) to enable the site(s):

```
sudo ln -s /etc/nginx/sites-available/thebox.taydev.net /etc/nginx/sites-enabled/thebox.taydev.net
sudo ln -s /etc/nginx/sites-available/dnd.taydev.net /etc/nginx/sites-enabled/dnd.taydev.net
```

After changing configs you should restart nginx.

## Let's Encrypt

Install the `certbot` cli as per instructions from: https://certbot.eff.org/

Once installed you should setup the symlinks into the `/etc/nginx/`
directories. Before running `certbot`, remove the `server` block with the SSL
certificates in it from each site you want to configure. Then run:

```
sudo certbot --nginx
```

and follow the prompts to generate new certificates or renew.

Verify the certs will autorenew by running:

```
sudo certbot renew --dry-run
```
