#!/bin/bash

export PATH=/bin:/sbin:/usr/bin:/usr/sbin

domain_name=`cat domain.list`
nameserver="8.8.4.4"
for i in $domain_name
do
    echo "$i:"
    dig @$nameserver $i | grep -A 1 "ANSWER SECTION:"
done
