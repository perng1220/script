#!/bin/bash

export PATH=/sbin:/bin:/usr/bin:/usr/sbin
backup_dir=/var/www/
backup_server_ip=192.168.2.19
backup_server_loginname=backup
backup_save_path=/backup/mail/238/www/

rsync -rlptgov --delete --log-file=/var/log/rsync.log --log-format="%t %l /%f %b" $backup_dir -e "ssh -p 1922" $backup_server_loginname@$backup_server_ip:$backup_save_path 2> /tmp/rsync_error
if [ "$?" != "0" ];then
    mail -s "Error: ts backup failed" itpacmis@gmail.com < /tmp/rsync_error
    rm -f /tmp/rsync_error
fi
