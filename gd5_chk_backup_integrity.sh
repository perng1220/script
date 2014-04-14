#!/bin/bash

export PATH=/bin:/sbin:/usr/bin:/usr/sbin
backup_save_path=/backup

check_gd4 ()
{
backup_integrity=`bzip2 -t $backup_save_path/gd4/www/www_$(date +"%Y%m%d").tar.bz2; echo $?`
if [ "$backup_integrity" != "0" ]; then
    echo "Check $backup_save_path/gd4/www/www_$(date +"%Y%m%d").tar.bz2 integrity failed" | mail -s "Error: gd4 check file integrity failed" itpacmis@gmail.com
else
    ls -l $backup_save_path/gd4/www/www*.tar.bz2 >> /tmp/filesize.txt
fi
backup_integrity=`bzip2 -t $backup_save_path/gd4/database/cmstm_$(date +"%Y%m%d").sql.bz2; echo $?`
if [ "$backup_integrity" != "0" ]; then
    echo "Check $backup_save_path/gd4/database/cmstm_$(date +"%Y%m%d").sql.bz2 integrity failed" | mail -s "Error: gd4 check file integrity failed" itpacmis@gmail.com
else
    ls -l $backup_save_path/gd4/database/cmstm*.sql.bz2 >> /tmp/filesize.txt
fi
backup_integrity=`bzip2 -t $backup_save_path/gd4/database/psa_$(date +"%Y%m%d").sql.bz2; echo $?`
if [ "$backup_integrity" != "0" ]; then
    echo "Check $backup_save_path/gd4/database/psa_$(date +"%Y%m%d").sql.bz2 integrity failed" | mail -s "Error: gd4 check file integrity failed" itpacmis@gmail.com
else
    ls -l $backup_save_path/gd4/database/psa*.sql.bz2 >> /tmp/filesize.txt
fi
if [ -e "/tmp/filesize.txt" ]; then
    mail -s "gd4 updated file list" itpacmis@gmail.com < /tmp/filesize.txt
    rm -f /tmp/filesize.txt
fi
}

case "$1" in
    "gd4" )
        check_gd4
        ;;
    * )
        echo "Usage: $0 {gd4}"
        ;;
esac

