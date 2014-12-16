#!/bin/bash
export PATH=/bin:/usr/bin:/sbin:/usr/sbin

id="37763 37915 37952 37972 38117 38168 38232 39024 39130 39560 39614 39681"
for i in $id
do
    if [ ! -d "/www_delete/$i" ]; then
        mkdir /www_delete/$i
    fi 
    if [ -d "/var/www/$i" ] && [ -d "/www_delete/$i" ]; then
        cp -av /var/www/$i/{images,themes,productpic} /www_delete/$i || exit 2
    else
       echo "Directory /var/www/$i or /www_delete/$i is not exist"
       exit 1
    fi
done
