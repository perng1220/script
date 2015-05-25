#!/bin/bash

taipei_office="122.146.56.224"
china_office1="113.0.0.0/255.0.0.0"
china_office2="112.94.171.10"
vpn_ip="54.201.2.82"
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
mysql_port="3306"
smtp_port="25"
nrpe_port="5666"
plesk_port="8443"
cat << EOF > /tmp/iptables.sh
export PATH="/sbin:/bin:/usr/sbin:/usr/bin"
NIC1="eth0"
NIC2="lo:1"
NIC3="lo:2"

iptables -F
iptables -X
iptables -Z
#iptables -t nat -F
#iptables -t nat -X
#iptables -t nat -Z

iptables -P INPUT ACCEPT
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT
#iptables -t nat -P POSTROUTING ACCEPT
#iptables -t nat -P PREROUTING ACCEPT
#iptables -t nat -P OUTPUT ACCEPT

iptables -N SSH
iptables -N HTTPS
iptables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A INPUT -p tcp --dport 25 -j LOG --log-level 4 --log-prefix '**SMTP** '
iptables -A INPUT -p tcp --dport $http_port -j LOG --log-level 4 --log-prefix '**HTTP** '
iptables -A INPUT -p tcp --dport $mysql_port -j LOG --log-level 4 --log-prefix '**MySQL** '
iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -p icmp -j ACCEPT
iptables -A INPUT -i \$NIC1 -p tcp --dport $ssh_port -j SSH
iptables -A SSH -s $taipei_office -p tcp --dport $ssh_port -m state --state NEW -j ACCEPT
iptables -A SSH -s $china_office1 -p tcp --dport $ssh_port -m state --state NEW -j ACCEPT
iptables -A SSH -s $china_office2 -p tcp --dport $ssh_port -m state --state NEW -j ACCEPT
iptables -A SSH -s $vpn_ip -p tcp --dport $ssh_port -m state --state NEW -j ACCEPT
iptables -A SSH -s $westhost_ip -p tcp --dport $ssh_port -m state --state NEW -j ACCEPT
iptables -A SSH -s $gd3_ip -p tcp --dport $ssh_port -m state --state NEW -j ACCEPT
iptables -A SSH -s $gd5_ip -p tcp --dport $ssh_port -m state --state NEW -j ACCEPT
iptables -A SSH -s $gd6_ip -p tcp --dport $ssh_port -m state --state NEW -j ACCEPT
iptables -A SSH -s $gd7_ip -p tcp --dport $ssh_port -m state --state NEW -j ACCEPT
#iptables -A SSH -s $vps_ip -p tcp --dport $ssh_port -m state --state NEW -j ACCEPT
iptables -A SSH -s $am_ip -p tcp --dport $ssh_port -m state --state NEW -j ACCEPT
iptables -A SSH -s $backup_ip -p tcp --dport $ssh_port -m state --state NEW -j ACCEPT
iptables -A SSH -s $mail_ip -p tcp --dport $ssh_port -m state --state NEW -j ACCEPT
iptables -A SSH -s $ts_ip -p tcp --dport $ssh_port -m state --state NEW -j ACCEPT
iptables -A SSH -i \$NIC1 -p tcp --dport $ssh_port -j DROP
iptables -A INPUT -p tcp --dport 25 -m state --state NEW -j ACCEPT
iptables -A INPUT -p tcp --dport $http_port -m state --state NEW -j ACCEPT
#iptables -A INPUT -i \$NIC1 -p tcp --dport $https_port -j HTTPS
#iptables -A HTTPS -s $taipei_office -p tcp --dport $https_port -m state --state NEW -j ACCEPT
#iptables -A HTTPS -s $vpn_ip -p tcp --dport $https_port -m state --state NEW -j ACCEPT
#iptables -A HTTPS -i \$NIC1 -p tcp --dport $https_port -j DROP
#iptables -A INPUT -i \$NIC1 -p tcp --dport $mysql_port -j ACCEPT
iptables -A INPUT -i \$NIC1 -s 54.201.2.82 -p tcp --dport $nrpe_port -j ACCEPT
#iptables -A INPUT -i \$NIC1 -s $taipei_office -p tcp --dport $plesk_port -m state --state NEW -j ACCEPT
#iptables -A INPUT -i \$NIC1 -s $vpn_ip -p tcp --dport $plesk_port -m state --state NEW -j ACCEPT
iptables -A INPUT -m state --state NEW,INVALID -j DROP
EOF
