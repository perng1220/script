#!/bin/bash
#Description:
#backup /var/www directory and mysql to gd4

export PATH=/bin:/sbin:/usr/bin:/usr/sbin
backup_file="/var/www/[0-9]*[0-9]/{images,themes,productpic} /var/www/datasync /var/www/initial /var/www/cmssources /etc/httpd/{conf,conf.d} /var/lib/awstats /etc/awstats"
backup_db="cmstm b2b_database"
backup_server_ip=182.50.154.190
backup_server_user=backup
backup_save_path=/backup

function backup_file ()
{
    if ! eval tar -jcvf - $backup_file | ssh -p 37501 $backup_server_user@$backup_server_ip "cat > $backup_save_path/gd3/www/www_`date +"%Y%m%d"`.tar.bz2"
    then
        echo "backup www_`date +"%Y%m%d"`.tar.bz2 failed" | mail -s "Error: gd3 backup failed" itpacmis@gmail.com
        exit 1
    fi
}

function backup_db ()
{
    for i in $backup_db
    do
        if mysqldump -ubackup -p'yvOhvC8I$Wf3nTcMHDpvkjsFLtPOjF1' -d -B cmstm > /dev/null
        then
            mysqldump  -ubackup -p'yvOhvC8I$Wf3nTcMHDpvkjsFLtPOjF1' -B $i | bzip2 -c | ssh -p 37501 $backup_server_user@$backup_server_ip "cat > $backup_save_path/gd3/database/${i}_`date +"%Y%m%d"`.sql.bz2"
        else
            echo "backup database ${i}_`date +"%Y%m%d"`.sql.bz2 failed" | mail -s "Error: gd3 backup failed" itpacmis@gmail.com
            exit 2
        fi
    done
}

function check_file_integrity ()
{
    if ! ssh -p 37501 $backup_server_user@$backup_server_ip "/var/scripts/chk_backup_integrity.sh gd3"
    then
        echo "check backup file integrity failed" | mail -s "Error: gd3 backup failed" itpacmis@gmail.com
        exit 3
    fi
}

case "$1" in
    "file" )
        backup_file
        ;;
    "db" )
        backup_db
        ;;
    "check" )
        check_file_integrity
        ;;
    * )
        echo "Usage: $0 {file|db|check}"
        ;;
esac
