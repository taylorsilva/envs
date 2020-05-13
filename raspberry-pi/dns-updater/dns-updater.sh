!/usr/bin/bash
# See knowlegebase article to config namecheap
# https://www.namecheap.com/support/knowledgebase/article.aspx/43/11/how-do-i-set-up-a-host-for-dynamic-dns
# make it executable `chmod +x ddns-update`
# move it path `mv ddns-update /usr/bin/`
# setup cronjob for every 15 minutes `crontab -e`
# */15 * * * * ddns-update >/dev/null 2>&1
# dont forget to change your own domain & password

# uncomment if you want internet connection check before running
#while ! ping -c 1 -W 1 8.8.8.8; do
#    echo "DDNS-UPDATE: Waiting internet connection.."
#    sleep 2
#done
last_ip_file="/tmp/last_ip"
last_ip=`cat $last_ip_file`
echo "DDNS-UPDATE: OK, Getting public IP address"
ip=$(curl -s http://dynamicdns.park-your-domain.com/getip)
if [ "$ip" == "$last_ip" ]; then
	echo "IP Still same, not need to update."
	exit 0
fi

echo "DDNS-UPDATE: Public IP is: $ip, Updating IP..."

host=thebox
domain=taydev.net
password=your-own-password-from-the-dns-manage-page
response=$(curl -s "https://dynamicdns.park-your-domain.com/update?host=$host&domain=$domain&password=$password&ip=$ip")
echo $response
echo $ip > $last_ip_file
