#!/bin/bash
export PATH=/bin:/sbin:/usr/bin:/usr/sbin

db_user=backup
db_password=sjGg84UlzZi~/ii
db_name="postfix roundcubemail"
backup_path=/backup/mail_db
for i in $db_name
do
    mysqldump -u$db_user -p$db_password $i > $backup_path/${i}_`date +"%Y%m%d"`.sql 2> /tmp/error 
    if [ "$?" == "0" ];then 
        cd $backup_path
        tar -jcf ${i}_`date +"%Y%m%d"`.sql.tar.bz2 ${i}_`date +"%Y%m%d"`.sql
        rm -f /tmp/error $backup_path/${i}_`date +"%Y%m%d"`.sql
    else
        mail -s "Error: Backup extmail db failed" itpacmis@gmail.com < /tmp/error
        rm -f /tmp/error $backup_path/${i}_`date +"%Y%m%d"`.sql
    fi
done
