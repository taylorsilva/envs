#!/usr/bin/env bash

set -euo pipefail

# See knowlegebase article to config namecheap
# https://www.namecheap.com/support/knowledgebase/article.aspx/43/11/how-do-i-set-up-a-host-for-dynamic-dns
# setup cronjob for every 15 minutes `crontab -e`
# */15 * * * * /path/to/dns-updater.sh >/dev/null 2>&1

last_ip_file="/tmp/last_ip"
last_ip=`cat $last_ip_file`
echo "DDNS-UPDATE: OK, Getting public IP address"
ip=$(hostname -I | cut -d' ' -f1)
if [ "$ip" == "$last_ip" ]; then
	echo "IP still the same, no need to update."
	exit 0
fi

echo "DDNS-UPDATE: Local IP is: $ip, Updating IP..."

host="insidethebox"
domain="taydev.net"
DIR=$(dirname $0)
# password should be set in .ddns-passwrd file locally on the server
# password=your-own-password-from-the-dns-manage-page
source $DIR/.ddns-password
response=$(curl -s "https://dynamicdns.park-your-domain.com/update?host=$host&domain=$domain&password=$password&ip=$ip")
echo $response
echo $ip > $last_ip_file
