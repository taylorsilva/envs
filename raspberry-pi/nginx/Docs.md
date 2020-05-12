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

Other `systemctl` commands include:
* `stop`
* `restart`
* `status`
* `show`

## Configuring nginx

All nginx configuration is under `/etc/nginx/`. The main config file is `nginx.conf`.
