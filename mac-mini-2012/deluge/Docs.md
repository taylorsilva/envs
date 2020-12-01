# Deluge

Deluge is split into two components: a front-end and back-end.

The front-end is the web ui component, called `deluge-web`
The back-end is the torrent client that downloads and seeds the torrents, called `deluged`.

## Installation

Sources:
* https://deluge.readthedocs.io/en/latest/how-to/systemd-service.html
* https://dev.deluge-torrent.org/wiki/Installing/Linux/Ubuntu

Add the Deluge PPA repository:
```
sudo add-apt-repository ppa:deluge-team/stable
sudo apt-get update
```

Install `deluged` and `deluge-web`:
```
sudo apt-get install deluged deluge-web
```

Next we'll setup the service account and configuration.

Create the service user:
```
sudo adduser --system  --gecos "Deluge Service" --disabled-password --group --home /var/lib/deluge deluge
```

Add the two `<name>.service` files to `/etc/systemd/system/`.

Create two folders to store the `user.conf` file in. The same `user.conf` is used for both services.
```
mkdir -p /etc/systemd/system/deluged.service.d/
mkdir -p /etc/systemd/system/deluge-web.service.d/
```

You can then start the service:
```
sudo systemctl start deluged
sudo systemctl start deluge-web
```

## Managing the service

The `deluged` service is set to reboot every 24hrs. Otherwies it has trouble announcing itself to trackers.
```
sudo systemctl [start/stop/restart/status] [deluged/deluge-web]
```

## Accessing the Web UI

Web UI is available over port 8112. Password is in your password manager. It starts with no password and it'll prompt you to set one.

## Moving Files

By default files are downloaded to `/var/lib/deluged`. You can move them using sudo or add your user accout to the `deluge` group:
```
sudo add user <user> deluge
```

Files need to follow a naming pattern as per the Jellyfin docs.

## Problem with python3-libtorrent

Issue is described here: [https://forum.deluge-torrent.org/viewtopic.php?f=7&t=55807&p=232588#p232588](https://forum.deluge-torrent.org/viewtopic.php?f=7&t=55807&p=232588#p232588)

Solution is pin the libtorrent dependencies to an older version:
```
sudo apt-get install python3-libtorrent=1.1.5-1build1 libtorrent-rasterbar9=1.1.5-1build1

```
sudo apt-mark hold python3-libtorrent
sudo apt-mark hold libtorrent-rasterbar9
```
