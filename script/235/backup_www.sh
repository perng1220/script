#!/bin/bash
export PATH=/bin:/sbin:/usr/bin:/usr/sbin

backup_dir=/var/www
tar_exclude_dir="--exclude=/var/www/dbadmin --exclude=/var/www/tast --exclude=/var/www/yun --exclude=/var/www/cgi-bin --exclude=/var/www/html/whousepic --exclude=/var/www/html/propicture --exclude=/var/www/html/buyingpic --exclude=/var/www/error --exclude=/var/www/icons"
find_exclude_dir="-path /var/www/dbadmin -prune -o -path /var/www/tast -prune -o -path /var/www/yun -prune -o -path /var/www/cgi-bin -prune -o -path /var/www/html/whousepic -prune -o -path /var/www/html/propicture -prune -o -path /var/www/html/buyingpic -prune -o -path /var/www/error -prune -o -path /var/www/icons -prune"

case $1 in
    "full" )
        tar -zcvf /backup/www/www_`date +"%Y%m%d"`_full.tar.gz $backup_dir $tar_exclude_dir
        #tar -jcf www_`date +"%Y%d%m"`.tar.bz2 $backup_dir
        ;;
    "diff" )
        find $backup_dir $find_exclude_dir -o -type f -newer /backup/www/www_`date -d "last saturday" +"%Y%m%d"`_full.tar.gz -print0 | tar --null -zcvf \
/backup/www/www_`date +"%Y%m%d"`.tar.gz  -T  -
        ;;
     * )
        echo "Usage: $0 {full|diff}"
        exit 1
        ;;
esac
