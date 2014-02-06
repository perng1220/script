#!/bin/bash

export PATH=/bin:/sbin:/usr/bin:/usr/sbin

domain_name=`cat domain.list`
for i in $domain_name
do
    nslookup $i
done
