#!/bin/bash

export PATH=/sbin:/bin:/usr/sbin:/usr/bin
INIF0=eth0

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
iptables -A INPUT -p tcp --dport 22 -m state --state NEW -j ACCEPT
iptables -A INPUT -p tcp -m multiport --dports 20,21,50000:50010 -m state --state NEW -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 53 -m state --state NEW -j ACCEPT 
iptables -A INPUT -p udp -m udp --dport 53 -m state --state NEW -j ACCEPT
iptables -A INPUT -p tcp -m multiport --dports 80 -m state --state NEW -j ACCEPT
iptables -A INPUT -p tcp -s 122.146.56.224 --dport 3000 -j ACCEPT
iptables -A INPUT -p udp --dport 1194 -m state --state NEW -j ACCEPT
iptables -A INPUT -m state --state NEW,INVALID -j DROP

iptables -A FORWARD -i tun0 -o eth0 -j ACCEPT 
iptables -A FORWARD -i eth0 -o tun0 -j ACCEPT 

iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
iptables -t nat -A POSTROUTING -o tun0 -j MASQUERADE

service fail2ban restart
