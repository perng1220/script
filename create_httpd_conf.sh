#!/bin/bash
export PATH=/sbin:/bin:/usr/sbin:/usr/bin

inputfile=$1
outputfile="/home/perng/gd1/gd1.conf"
lines=`wc -l $inputfile | cut -d " " -f 1`
for ((i=1;i<=$lines;i++))
do
domain=`awk -v filed="$i" 'BEGIN{FS=","}NR==filed{print $1}' $inputfile`
site_id=`awk -v filed="$i" 'BEGIN{FS=","}NR==filed{print $2}' $inputfile`
cat << EOF >> $outputfile
<VirtualHost 182.50.154.193:80>
    ServerName $domain
    ServerAlias www.$domain
    CustomLog logs/${domain}_access_log combined
    ErrorLog logs/${domain}_error_log
    DocumentRoot "$site_id"
    <Directory "$site_id">
        Options +Indexes +FollowSymLinks
        Order allow,deny
        Allow from all
        AllowOverride All
    </Directory>
</VirtualHost>

EOF
done
