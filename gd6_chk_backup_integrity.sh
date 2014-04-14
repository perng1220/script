#!/bin/bash

export PATH=/bin:/sbin:/usr/bin:/usr/sbin
backup_save_path=/backup

check_gd1 ()
{
backup_integrity=`bzip2 -t $backup_save_path/gd1/www/www_$(date +"%Y%m%d").tar.bz2; echo $?`
if [ "$backup_integrity" != "0" ]; then
    echo "Check $backup_save_path/gd1/www/www_$(date +"%Y%m%d").tar.bz2 integrity failed" | mail -s "Error: gd1 check file integrity failed" itpacmis@gmail.com
else
    ls -l $backup_save_path/gd1/www/www*.tar.bz2 >> /tmp/filesize.txt
fi
backup_integrity=`bzip2 -t $backup_save_path/gd1/database/cmstm_$(date +"%Y%m%d").sql.bz2; echo $?`
if [ "$backup_integrity" != "0" ]; then
    echo "Check $backup_save_path/gd1/www/cmstm_$(date +"%Y%m%d").sql.bz2 integrity failed" | mail -s "Error: gd1 check file integrity failed" itpacmis@gmail.com
else
    ls -l $backup_save_path/gd1/database/cmstm*.sql.bz2 >> /tmp/filesize.txt
fi
backup_integrity=`bzip2 -t $backup_save_path/gd1/database/psa_$(date +"%Y%m%d").sql.bz2; echo $?`
if [ "$backup_integrity" != "0" ]; then
    echo "Check $backup_save_path/gd1/www/psa_database_$(date +"%Y%m%d").sql.bz2 integrity failed" | mail -s "Error: gd1 check file integrity failed" itpacmis@gmail.com
else
    ls -l $backup_save_path/gd1/database/psa*.sql.bz2 >> /tmp/filesize.txt
fi
if [ -e "/tmp/filesize.txt" ]; then
    mail -s "gd1 updated file list" itpacmis@gmail.com < /tmp/filesize.txt
    rm -f /tmp/filesize.txt
fi
}

check_gd7 ()
{
backup_integrity=`bzip2 -t $backup_save_path/gd7/www/www_$(date +"%Y%m%d").tar.bz2; echo $?`
if [ "$backup_integrity" != "0" ]; then
    echo "Check $backup_save_path/gd7/www/www_$(date +"%Y%m%d").tar.bz2 integrity failed" | mail -s "Error: gd7 check file integrity failed" itpacmis@gmail.com
else
    ls -l $backup_save_path/gd7/www/www*.tar.bz2 >> /tmp/filesize.txt
fi
backup_integrity=`bzip2 -t $backup_save_path/gd7/database/cmstm_$(date +"%Y%m%d").sql.bz2; echo $?`
if [ "$backup_integrity" != "0" ]; then
    echo "Check $backup_save_path/gd7/www/cmstm_$(date +"%Y%m%d").sql.bz2 integrity failed" | mail -s "Error: gd7 check file integrity failed" itpacmis@gmail.com
else
    ls -l $backup_save_path/gd7/database/cmstm*.sql.bz2 >> /tmp/filesize.txt
fi
backup_integrity=`bzip2 -t $backup_save_path/gd7/database/psa_$(date +"%Y%m%d").sql.bz2; echo $?`
if [ "$backup_integrity" != "0" ]; then
    echo "Check $backup_save_path/gd7/www/psa_$(date +"%Y%m%d").sql.bz2 integrity failed" | mail -s "Error: gd7 check file integrity failed" itpacmis@gmail.com
else
    ls -l $backup_save_path/gd7/database/psa*.sql.bz2 >> /tmp/filesize.txt
fi
if [ -e "/tmp/filesize.txt" ]; then
    mail -s "gd7 updated file list" itpacmis@gmail.com < /tmp/filesize.txt
    rm -f /tmp/filesize.txt
fi
}
case "$1" in
    "gd1" )
        check_gd1
        ;;
    "gd7" )
        check_gd7
        ;;
    * )
        echo "Usage: $0 {gd1|gd7}"
        ;;
esac
