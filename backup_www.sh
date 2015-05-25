#!/bin/bash
export PATH=/bin:/sbin:/usr/bin:/usr/sbin

backup_dir=/var/www
exclude_dir="--exclude=/var/www/dbadmin --exclude=/var/www/tast --exclude=/var/www/yun --exclude=/var/www/cgi-bin --exclude=/var/www/html/whousepic"

tar -jcf www_`date +"%Y%d%m"`.tar.bz2 $backup_dir $exclude_dir 
#tar -jcf www_`date +"%Y%d%m"`.tar.bz2 $backup_dir
