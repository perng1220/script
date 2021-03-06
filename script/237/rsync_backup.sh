#!/bin/bash

export PATH=/sbin:/bin:/usr/bin:/usr/sbin
back_dir="/var/spool/mail /backup/mail/* /backup/etc"
exclude_dir="--exclude 238 --exclude tmp"
backup_server_ip=192.168.2.18
backup_server_loginname=backup
backup_save_path=/backup/237

rsync -rlptgov --delete --log-format="%t %l /%f %b" $exclude_dir $back_dir --log-file=/var/log/rsync.log -e "ssh -p 1822" $backup_server_loginname@$backup_server_ip:$backup_save_path 2> /tmp/rsync_error
if [ "$?" != "0" ];then
    mail -s "Error: mail backup failed" itpacmis@gmail.com < /tmp/rsync_error
    rm -f /tmp/rsync_error
fi
