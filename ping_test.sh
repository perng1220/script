#!/bin/bash

export PATH=/bin:/sbin:/usr/bin:/usr/sbin
pwd=$(pwd)
if [ -z "$pwd/iplist.txt" ]; then
   ip_addr=$(cat $pwd/iplist.txt)
else
   exit 1
fi

ping -c5 168.95.1.1 | grep avg | cut -d "/" -f 5
