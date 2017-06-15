#!/bin/bash
export PATH="/bin:/sbin:/usr/sbin:/usr/bin"

function download_config_files
{
if [ -e /etc/openvpn ]; then
  wget https://www.hidemyass.com/vpn-config/TCP/Taiwan.Taipei_LOC1S1.TCP.ovpn -O /etc/openvpn/hma_twn1.conf || \
echo "Download Taiwan.Taipei_LOC1S1.TCP.ovpn failed" | mail -s "Error: Download failed" itpac@localhost
  wget https://www.hidemyass.com/vpn-config/TCP/Taiwan.Taipei_LOC1S4.TCP.ovpn -O /etc/openvpn/hma_twn2.conf || \
echo "Download Taiwan.Taipei_LOC1S4.TCP.ovpn failed" | mail -s "Error: Download failed" itpac@localhost
  wget https://www.hidemyass.com/vpn-config/TCP/Taiwan.Taipei_LOC1S5.TCP.ovpn -O /etc/openvpn/hma_twn3.conf || \
echo "Download Taiwan.Taipei_LOC1S5.TCP.ovpn failed" | mail -s "Error: Download failed" itpac@localhost
  wget https://www.hidemyass.com/vpn-config/TCP/Taiwan.Taipei_LOC1S6.TCP.ovpn -O /etc/openvpn/hma_twn4.conf || \
echo "Download Taiwan.Taipei_LOC1S6.TCP.ovpn failed" | mail -s "Error: Download failed" itpac@localhost
  echo $renewal_date > /etc/openvpn/renewal.txt
else
  echo "/etc/openvpn is not exist"
fi
}

renewal_date=`curl -s https://www.hidemyass.com/vpn-config/TCP/ | html2text -width 120 | grep Taiwan | awk '{ print $2 }' | sort -u`
if [ "$renewal_date" != "$(cat /etc/openvpn/renewal.txt)" ]; then
  download_config_files;
else
  exit 0
fi
