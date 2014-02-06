#!/bin/bash
export PATH=/sbin:/bin:/usr/sbin:/usr/bin

file=$1
lines=`wc -l $file | cut -d " " -f 1`
for ((i=1;i<=$lines;i++))
do
domain=`awk -v var="$i" 'BEGIN{FS=","}NR==var{print $1}' $file`
cat << EOF > ~/gd1/awstats.$domain.conf
Include "awstats.common.conf"
LogFile="/var/log/httpd/${domain}_access_log"
SiteDomain="$domain"
HostAliases="$domain www.$domain"
EOF
done
