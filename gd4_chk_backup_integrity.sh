#!/bin/bash

export PATH=/bin:/sbin:/usr/bin:/usr/sbin
backup_save_path=/backup

check_gd3 ()
{
backup_integrity=`bzip2 -t $backup_save_path/gd3/www/www_$(date +"%Y%m%d").tar.bz2; echo $?`
if [ "$backup_integrity" != "0" ]; then
    echo "Check $backup_save_path/gd3/www/www_$(date +"%Y%m%d").tar.bz2 integrity failed" | mail -s "Error: gd3 check file integrity failed" itpacmis@gmail.com
else
    ls -l $backup_save_path/gd3/www/www*.tar.bz2 >> /tmp/filesize.txt
fi
backup_integrity=`bzip2 -t $backup_save_path/gd3/database/cmstm_$(date +"%Y%m%d").sql.bz2; echo $?`
if [ "$backup_integrity" != "0" ]; then
    echo "Check $backup_save_path/gd3/www/cmstm_$(date +"%Y%m%d").sql.bz2 integrity failed" | mail -s "Error: gd3 check file integrity failed" itpacmis@gmail.com
else
    ls -l $backup_save_path/gd3/database/cmstm*.sql.bz2 >> /tmp/filesize.txt
fi
backup_integrity=`bzip2 -t $backup_save_path/gd3/database/b2b_database_$(date +"%Y%m%d").sql.bz2; echo $?`
if [ "$backup_integrity" != "0" ]; then
    echo "Check $backup_save_path/gd3/www/b2b_database_$(date +"%Y%m%d").sql.bz2 integrity failed" | mail -s "Error: gd3 check file integrity failed" itpacmis@gmail.com
else
    ls -l $backup_save_path/gd3/database/b2b_database*.sql.bz2 >> /tmp/filesize.txt
fi
if [ -e "/tmp/filesize.txt" ]; then
    mail -s "gd3 updated file list" itpacmis@gmail.com < /tmp/filesize.txt
    rm -f /tmp/filesize.txt
fi
}

check_gd5 ()
{
backup_integrity=`bzip2 -t $backup_save_path/gd5/www/www_$(date +"%Y%m%d").tar.bz2; echo $?`
if [ "$backup_integrity" != "0" ]; then
    echo "Check $backup_save_path/gd5/www/www_$(date +"%Y%m%d").tar.bz2 integrity failed" | mail -s "Error: gd5 check file integrity failed" itpacmis@gmail.com
else
    ls -l $backup_save_path/gd5/www/www*.tar.bz2 >> /tmp/filesize.txt
fi
backup_integrity=`bzip2 -t $backup_save_path/gd5/database/cmstm_$(date +"%Y%m%d").sql.bz2; echo $?`
if [ "$backup_integrity" != "0" ]; then
    echo "Check $backup_save_path/gd5/www/cmstm_$(date +"%Y%m%d").sql.bz2 integrity failed" | mail -s "Error: gd5 check file integrity failed" itpacmis@gmail.com
else
    ls -l $backup_save_path/gd5/database/cmstm*.sql.bz2 >> /tmp/filesize.txt
fi
backup_integrity=`bzip2 -t $backup_save_path/gd5/database/psa_$(date +"%Y%m%d").sql.bz2; echo $?`
if [ "$backup_integrity" != "0" ]; then
    echo "Check $backup_save_path/gd5/www/psa_$(date +"%Y%m%d").sql.bz2 integrity failed" | mail -s "Error: gd5 check file integrity failed" itpacmis@gmail.com
else
    ls -l $backup_save_path/gd5/database/psa*.sql.bz2 >> /tmp/filesize.txt
fi
if [ -e "/tmp/filesize.txt" ]; then
    mail -s "gd5 updated file list" itpacmis@gmail.com < /tmp/filesize.txt
    rm -f /tmp/filesize.txt
fi
}

case "$1" in
    "gd3" )
        check_gd3
        ;;
    "gd5" )
        check_gd5
        ;;
    * )
        echo "Usage: $0 {gd3|gd5}"
        ;;
esac
