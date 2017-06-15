#!/bin/bash
#Description:
#backup files and db to gd6

export PATH=/bin:/sbin:/usr/bin:/usr/sbin
backup_file="/var/www /etc /usr/local/psa/etc /var/scripts"
backup_db="cmstm psa magic db_yewu zhenzhu"
backup_server_ip=50.63.153.91
backup_server_user=backup
backup_save_path=/backup

function backup_file ()
{
    if ! eval tar -jcvf - $backup_file | ssh -p 36821 $backup_server_user@$backup_server_ip "cat > $backup_save_path/gd5/www/www_`date +"%Y%m%d"`.tar.bz2"
    then
        echo "backup www_`date +"%Y%m%d"`.tar.bz2 failed" | mail -s "Error: gd5 backup failed" itpacmis@gmail.com
        exit 1
    fi
}

function backup_db ()
{
    for i in $backup_db
    do
        if mysqldump -ubackup -p'5/4kg8vU&eXzZfi' -d -B psa > /dev/null
        then
            mysqldump  -ubackup -p'5/4kg8vU&eXzZfi' -B $i | bzip2 -c | ssh -p 36821 $backup_server_user@$backup_server_ip "cat > $backup_save_path/gd5/database/${i}_`date +"%Y%m%d"`.sql.bz2"
        else
            echo "backup database ${i}_`date +"%Y%m%d"`.sql.bz2 failed" | mail -s "Error: gd5 backup failed" itpacmis@gmail.com
            exit 2
        fi
    done
}

function check_file_integrity ()
{
    if ! ssh -p 36821 $backup_server_user@$backup_server_ip "/var/scripts/chk_backup_integrity.sh gd5"
    then
        echo "check backup file integrity failed" | mail -s "Error: gd5 backup failed" itpacmis@gmail.com
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
