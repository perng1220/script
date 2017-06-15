#!/bin/bash
export PATH=/bin:/sbin:/usr/bin:/usr/sbin

user=repl
password='uki-QqeLza90'
mysql -u$user -p$password -e 'SHOW SLAVE STATUS\G' | grep -E 'Slave_IO_Running|Slave_SQL_Running' > /tmp/repl_status
Slave_IO_Running=`grep Slave_IO_Running /tmp/repl_status | cut -d ":" -f 2 | sed 's/\ //g'`
Slave_SQL_Running=`grep Slave_SQL_Running /tmp/repl_status | cut -d ":" -f 2 | sed 's/\ //g'`
if [ "$Slave_IO_Running" == "Yes" ] && [ "$Slave_SQL_Running" == "Yes" ]; then
    rm -f /tmp/repl_status
else
    mutt -F /root/.muttrc -s "Error:$(hostname) replication failed" mis@itpac.org < /tmp/repl_status
    rm -f /tmp/repl_status
fi
