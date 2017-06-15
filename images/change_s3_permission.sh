#!/bin/bash
export PATH=/bin:/sbin:/usr/bin:/usr/sbin

file_list="/root/filelist.txt"

for i in `cat $file_list`
do 
    echo "Processing $i" >> /root/change.log
    aws s3api put-object-acl --acl public-read --bucket hoten-images --key $i 2>> /root/change.log
done
