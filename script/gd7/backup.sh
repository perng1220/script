#!/bin/bash
#Description:
#backup flies and db to gd5

export PATH=/bin:/sbin:/usr/bin:/usr/sbin
backup_file="/var/www /etc /usr/local/psa/etc /var/scripts"
backup_db="cmstm psa cms_coid"
backup_server_ip=118.139.182.181
backup_server_user=backup
backup_save_path=/backup

function backup_file ()
{
    if ! eval tar -jcvf - $backup_file | ssh -p 41936 $backup_server_user@$backup_server_ip "cat > $backup_save_path/gd7/www/www_`date +"%Y%m%d"`.tar.bz2"
    then
        echo "backup www_`date +"%Y%m%d"`.tar.bz2 failed" | mail -s "Error: gd7 backup failed" itpacmis@gmail.com
        exit 1
    fi
}

function backup_db ()
{
    for i in $backup_db
    do
        if mysqldump -ubackup -p'BC/p2kU,pd35wui' -d -B psa > /dev/null
        then
            mysqldump  -ubackup -p'BC/p2kU,pd35wui' -B $i | bzip2 -c | ssh -p 41936 $backup_server_user@$backup_server_ip "cat > $backup_save_path/gd7/database/${i}_`date +"%Y%m%d"`.sql.bz2"
        else
            echo "backup database ${i}_`date +"%Y%m%d"`.sql.bz2 failed" | mail -s "Error: gd7 backup failed" itpacmis@gmail.com
            exit 2
        fi
    done
}

function check_file_integrity ()
{
    if ! ssh -p 41936 $backup_server_user@$backup_server_ip "/var/scripts/chk_backup_integrity.sh gd7"
    then
        echo "check backup file integrity failed" | mail -s "Error: gd7 backup failed" itpacmis@gmail.com
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
