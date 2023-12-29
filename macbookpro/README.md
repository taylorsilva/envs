# Fedora 39 Setup

## Wifi Setup

Had to do the following to setup Wifi. Connected the laptop to ethernet and ran the following commands:

```
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo dnf config-manager --enable fedora-cisco-openh264
sudo reboot now
```

```
sudo dnf update
sudo dnf broadcom-wl
sudo reboot now
```

Now we can connect.
```
$ nmcli device status
DEVICE  TYPE      STATE                   CONNECTION
wlp2s0  wifi      disconnected            ---
lo      loopback  connected (externally)  lo

$ nmcli device wifi connect <SSID> --ask
<will prompt for password. May initially says it failed but will add it>
$ nmcli device status
DEVICE  TYPE      STATE                   CONNECTION
wlp2s0  wifi      connected               Roshar
lo      loopback  connected (externally)  lo
```

If you're havin Wifi issues try rebooting or `sudo service NetworkManager restart`.

Sources:
- https://rpmfusion.org/Configuration
- https://docs.fedoraproject.org/en-US/quick-docs/configuring-ip-networking-with-nmcli/#_brief_selection_of_nmcli_examples
- https://www.networkmanager.dev/docs/api/latest/nmcli.html

## Disable Lid Triggering Sleep Mode

Edit `/etc/systemd/logind.conf` and set `HandleLidSwitch` to `ignore`.

```
HandleLidSwitch=ignore
```

Then restart `systemd-logind`
```
systemctl restart systemd-logind
```
