#!/bin/sh
export PATH=/bin:/sbin:/usr/bin:/usr/sbin
tmpwatch_opt="-m 120 -X /backup/mail/www_238 -X /backup/mail/tmp" 

tar -zcvf /backup/mail/mailbak_`date +"%Y%m%d"`.tar.gz --exclude /var/spool/mail/deleted-maildirs /var/spool/mail \
> /dev/null 2> /tmp/backupmail.err

if [ "$?" != "0" ]; then
    mutt -F /root/.muttrc -s "Error:$(hostname) backup mail failed" mis@itpac.org < /tmp/backupmail.err
    bb /tmp/backupmail.err
    exit 1
else
    tmpwatch --verbose $tmpwatch_opt /backup/mail/ > /var/log/tmpwatch.log 2>&1
fi
