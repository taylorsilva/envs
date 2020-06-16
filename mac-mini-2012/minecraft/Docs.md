# Installation

Initially setup with Spigot but PaperMC claims to be faster. Still java based.

PaperMC: https://papermc.io/
Spigot: https://www.spigotmc.org/

Simply download (or compile the jar) and install Java.

Place `start.sh` in the directory where the mincraft server files are located. Update the locations in the script as needed.

Add the `minecraft.service` file to `/etc/systemd/system/`
Add the `user.conf` file to `/etc/systemd/system/minecraft.service.d/`.

Create the user `minecraft` which the service will run as:

```
sudo adduser --system  --gecos "Minecraft Service" --disabled-password --group --home /var/lib/minecraft minecraft
```

# Maintaining The Service

To start or stop use `systemctl`

```
sudo systemctl [start/stop/status/restart] minecraft
```
