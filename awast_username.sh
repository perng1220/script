#!/bin/bash

export PATH=/bin:/sbin:/usr/bin:/usr/sbin

domain=$(find /var/www/vhosts -maxdepth 1 -type d | sort)
for i in $domain
do
    echo $i | cut -d "/" -f 5
    cat $i/pd/d..http* | sed 's/:/\ /g'
    echo -e "\n"
done
