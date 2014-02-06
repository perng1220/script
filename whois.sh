#!/bin/bash

export PATH=/bin:/sbin:/usr/bin:/usr/sbin

domain_name=`cat domain.list`
for i in $domain_name
do
    echo $i
    whois $i | grep -iE "creat|expir" | grep -Ev "NOTICE:|currently set to expire|view the registrar's reported date of expiration for this registration."
done
