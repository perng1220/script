#!/bin/bash

taipei_office="122.146.56.224"
china_office="113.0.0.0/255.0.0.0"
ftp_ip="54.201.2.82"
westhost_ip="206.130.105.198"
gd3_ip="182.50.154.193"
gd5_ip="118.139.182.181"
gd6_ip="50.63.153.91"
gd7_ip="50.63.138.195"
vps_ip="203.124.121.39"
am_ip="202.134.127.235"
backup_ip="202.134.127.236"
mail_ip="202.134.127.237"
ts_ip="202.134.127.238"

ssh_port="22"
http_port="80"
https_port="443"
cat << EOF > /tmp/iptables.sh
export PATH="/sbin:/bin:/usr/sbin:/usr/bin"
INIF0="eth0"

iptables -F
iptables -X
iptables -Z
iptables -t nat -F
iptables -t nat -X
iptables -t nat -Z

iptables -P INPUT ACCEPT
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT
iptables -t nat -P POSTROUTING ACCEPT
iptables -t nat -P PREROUTING ACCEPT
iptables -t nat -P OUTPUT ACCEPT

iptables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -p icmp -j ACCEPT
iptables -N SSH
iptables -A SSH -s $taipei_office -p tcp --dport $ssh_port -m state --state NEW -j ACCEPT
iptables -A SSH -s $china_office -p tcp --dport $ssh_port -m state --state NEW -j ACCEPT
iptables -A SSH -s $ftp_ip -p tcp --dport $ssh_port -m state --state NEW -j ACCEPT
iptables -A SSH -s $westhost_ip -p tcp --dport $ssh_port -m state --state NEW -j ACCEPT
iptables -A SSH -s $gd5_ip-p tcp --dport $ssh_port -m state --state NEW -j ACCEPT
iptables -A SSH -s $gd6_ip -p tcp --dport $ssh_port -m state --state NEW -j ACCEPT
iptables -A SSH -s $gd7_ip -p tcp --dport $ssh_port -m state --state NEW -j ACCEPT
iptables -A SSH -s $am_ip -p tcp --dport $ssh_port -m state --state NEW -j ACCEPT
iptables -A SSH -s $backup_ip -p tcp --dport $ssh_port -m state --state NEW -j ACCEPT
iptables -A SSH -s $mail_ip -p tcp --dport $ssh_port -m state --state NEW -j ACCEPT
iptables -A SSH -s $ts_ip -p tcp --dport $ssh_port -m state --state NEW -j ACCEPT
iptables -A SSH -p tcp --dport $ssh_port -j RETURN
iptables -A INPUT -p tcp -m multiport --dports $http_port,$https_port -m state --state NEW -j ACCEPT
iptables -A INPUT -m state --state NEW,INVALID -j DROP

EOF
