export PATH="/sbin:/bin:/usr/sbin:/usr/bin"
NIC1="eth0"

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

iptables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
#iptables -A INPUT -p tcp --dport 80 -j LOG --log-level 4 --log-prefix '**HTTP** '
#iptables -A INPUT -p tcp -m tcp --tcp-flags FIN,SYN,RST,PSH,ACK,URG SYN -m limit --limit 8/min -j LOG --log-prefix "**SYN-LIMIT** "
iptables -A INPUT -i lo -j ACCEPT
iptables -A INPUT -i $NIC1 -s 122.146.56.224 -p icmp -m icmp --icmp-type 8 -j ACCEPT
iptables -A INPUT -i $NIC1 -s 54.201.2.82 -p icmp -m icmp --icmp-type 8 -j ACCEPT
iptables -A INPUT -i $NIC1 -p icmp -m icmp --icmp-type 8 -j DROP
#iptables -A INPUT -p tcp -m tcp --dport 53 -m state --state NEW -j ACCEPT
#iptables -A INPUT -p udp -m udp --dport 53 -m state --state NEW -j ACCEPT
iptables -A INPUT -i $NIC1 -s 122.146.56.224 -p tcp -m tcp --dport 3306 -m state --state NEW -j ACCEPT
iptables -A INPUT -i $NIC1 -s 122.146.56.224 -p tcp --dport 22 -m state --state NEW -j ACCEPT
iptables -A INPUT -i $NIC1 -s 113.0.0.0/255.0.0.0 -p tcp --dport 22 -m state --state NEW -j ACCEPT
iptables -A INPUT -i $NIC1 -s 112.94.171.10 -p tcp --dport 22 -m state --state NEW -j ACCEPT
iptables -A INPUT -i $NIC1 -s 54.201.2.82 -p tcp --dport 22 -m state --state NEW -j ACCEPT
iptables -A INPUT -i $NIC1 -s 206.130.105.198 -p tcp --dport 22 -m state --state NEW -j ACCEPT
iptables -A INPUT -i $NIC1 -s 182.50.154.193 -p tcp --dport 22 -m state --state NEW -j ACCEPT
iptables -A INPUT -i $NIC1 -s 118.139.182.181 -p tcp --dport 22 -m state --state NEW -j ACCEPT
iptables -A INPUT -i $NIC1 -s 50.63.153.91 -p tcp --dport 22 -m state --state NEW -j ACCEPT
iptables -A INPUT -i $NIC1 -s 50.63.138.195 -p tcp --dport 22 -m state --state NEW -j ACCEPT
iptables -A INPUT -i $NIC1 -s 202.134.127.235 -p tcp --dport 22 -m state --state NEW -j ACCEPT
iptables -A INPUT -i $NIC1 -s 202.134.127.236 -p tcp --dport 22 -m state --state NEW -j ACCEPT
iptables -A INPUT -i $NIC1 -s 202.134.127.237 -p tcp --dport 22 -m state --state NEW -j ACCEPT
iptables -A INPUT -i $NIC1 -s 202.134.127.238 -p tcp --dport 22 -m state --state NEW -j ACCEPT
iptables -A INPUT -i $NIC1 -p tcp --dport 22 -j DROP
iptables -A INPUT -i $NIC1 -p tcp --dport 80 -m state --state NEW -j ACCEPT
iptables -A INPUT -i $NIC1 -s 54.201.2.82 -p tcp --dport 5666 -j ACCEPT
iptables -A INPUT -m state --state NEW,INVALID -j DROP

service fail2ban restart
