#!/bin/bash
export PATH=/bin:/sbin:/usr/bin:/usr/sbin

tar -jcf /backup/etc/etc_`date +"%Y%m%d"`.tar.bz2 /etc /var/scripts | mail -s "Error: taiwan-suppliers backup /etc failed"
