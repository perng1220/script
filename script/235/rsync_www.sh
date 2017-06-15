#!/bin/bash

export PATH=/sbin:/bin:/usr/bin:/usr/sbin
backup_dir=/var/www/
backup_server_ip=192.168.2.18
backup_server_loginname=backup
backup_save_path=/var/www/www_235/

rsync -rlptgov --delete --log-file=/var/log/rsync.log --log-format="%t %l /%f %b" $backup_dir -e "ssh -p 1822" $backup_server_loginname@$backup_server_ip:$backup_save_path 2> /tmp/rsync_error
if [ "$?" != "0" ];then
    mail -s "Error: am backup failed" itpacmis@gmail.com < /tmp/rsync_error
    rm -f /tmp/rsync_error
fi
