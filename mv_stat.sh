#!/bin/bash
export PATH=/bin:/sbin:/usr/sbin:/usr/bin

domain=`cat $1`
for i in $domain
do
    if [ -d "/var/www/vhosts/$i/statistics/webstat" ]; then
        cp -av $i/statistics/webstat/* /var/www/vhosts/$i/statistics/webstat/ || exit
        chown -R root:root /var/www/vhosts/$i/statistics/webstat/* || exit
        chgrp psaserv /var/www/vhosts/$i/statistics/webstat/index.html || exit
        chown tiwitang:tiwitang /var/www/vhosts/$i || exit
        chmod a+x /var/www/vhosts/$i/pd /var/www/vhosts/$i/statistics || exit
        chmod a+r /var/www/vhosts/$i/pd/* || exit
    else
        echo "/var/www/vhosts/$i/statistics/webstat is not exist"
        exit
    fi
done
