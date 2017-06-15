#!/bin/sh
shdir=$(cd "$(dirname "$0")"; pwd)
backupdir='/backup/tm_b2b'
rq=` date +%Y%m%d%H%M `
mysqldump -utm_b2b -p20118899ii.. tm_b2b --default-character-set=utf8 --opt --extended-insert=true --triggers=false -R --hex-blob --single-transaction > ${shdir}/${backupdir}/tm_b2b.$rq.sql
tar --remove-files -zcf ${shdir}/${backupdir}/tm_b2b.$rq.sql.tar.gz ${shdir}/${backupdir}/tm_b2b.$rq.sql
