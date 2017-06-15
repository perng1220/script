#!/bin/bash
export PATH=/bin:/sbin:/usr/bin:/usr/sbin

tar -jcf /backup/etc/etc_`date +"%Y%m%d"`.tar.bz2 /etc /var/scripts|| mail -s "Error: am backup /etc failed" itpacmis@gmail.com
