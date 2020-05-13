# OpenVPN

## Installation

Make sure you have the submodule in this folder loaded

```
git submodule update --init
cd ~/env/raspberry-pi/openvpn/openvpn-install/
git checkout master
git pull
```

Then execute the installation script

```
sudo ~/envs/raspberry-pi/openvpn/openvpn-install/openvpn-install.sh
```

Check out the README in the `openvpn-install` repo for more details.

## Options I selected during install

IP address: 10.88.111.17

Public IPv4 address or hostname: thebox.taydev.net

Do you want to enable IPv6 support (NAT)? no

Port to listen to? 1194 (default)

Protocol to use? UDP

DNS resolver? Current system resolvers (from /etc/resolv.conf)

Enable compression? no

Customize encryption settings? no

Client name: taylor
Selected passwordless client

Resulted in `/home/pi/taylor.ovpn` file
