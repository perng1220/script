#!/bin/bash
export PATH=/bin:/sbin:/usr/bin:/usr/sbin

tar -zcvf /backup/etc/etc_`date +"%Y%m%d"`.tar.gz /etc /var/scripts || mail -s "Error: mail backup /etc failed" itpacmis@gmail.com
