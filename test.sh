#!/bin/bash
export PATH=/sbin:/bin:/usr/sbin:/usr/bin

file=$1
site_id=`awk 'BEGIN{FS=","}NR==2{ print $2 }' $file`
