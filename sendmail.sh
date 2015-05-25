#!/bin/bash
export PATH=/bin:/usr/bin:/sbin:/usr/sbin

#uuencode /root/mail /root/mail | mail -s "test" test1@aa.com
#uuencode /root/mail /root/mail | mail -s "test" test2@aa.com
#uuencode /root/mail /root/mail | mail -s "test" test3@bb.com
#uuencode /root/mail /root/mail | mail -s "test" test4@bb.com

n=$((RANDOM%12+1))
case "$n" in
    "1" ) 
        mutt -F /root/test1_muttrc -s "test" -a /usr/share/doc/rpm-4.4.2.3/ChangeLog test2@aa.com < /usr/share/doc/clamav-0.98.5/ChangeLog
        ;;
    "2" )
        mutt -F /root/test1_muttrc -s "test" -a /usr/share/doc/rpm-4.4.2.3/ChangeLog test3@bb.com < /usr/share/doc/clamav-0.98.5/ChangeLog
        ;;
    "3" )
        mutt -F /root/test1_muttrc -s "test" -a /usr/share/doc/rpm-4.4.2.3/ChangeLog test4@bb.com < /usr/share/doc/clamav-0.98.5/ChangeLog
        ;;
    "4" ) 
        mutt -F /root/test2_muttrc -s "test" -a /usr/share/doc/rpm-4.4.2.3/ChangeLog test1@aa.com < /usr/share/doc/clamav-0.98.5/ChangeLog
        ;;
    "5" )
        mutt -F /root/test2_muttrc -s "test" -a /usr/share/doc/rpm-4.4.2.3/ChangeLog test3@bb.com < /usr/share/doc/clamav-0.98.5/ChangeLog
        ;;
    "6" )
        mutt -F /root/test2_muttrc -s "test" -a /usr/share/doc/rpm-4.4.2.3/ChangeLog test4@bb.com < /usr/share/doc/clamav-0.98.5/ChangeLog
        ;;
    "7" ) 
        mutt -F /root/test3_muttrc -s "test" -a /usr/share/doc/rpm-4.4.2.3/ChangeLog test1@aa.com < /usr/share/doc/clamav-0.98.5/ChangeLog
        ;;
    "8" )
        mutt -F /root/test3_muttrc -s "test" -a /usr/share/doc/rpm-4.4.2.3/ChangeLog test2@aa.com < /usr/share/doc/clamav-0.98.5/ChangeLog
        ;;
    "9" )
        mutt -F /root/test3_muttrc -s "test" -a /usr/share/doc/rpm-4.4.2.3/ChangeLog test4@bb.com < /usr/share/doc/clamav-0.98.5/ChangeLog
        ;;
    "10" ) 
        mutt -F /root/test4_muttrc -s "test" -a /usr/share/doc/rpm-4.4.2.3/ChangeLog test1@aa.com < /usr/share/doc/clamav-0.98.5/ChangeLog
        ;;
    "11" )
        mutt -F /root/test4_muttrc -s "test" -a /usr/share/doc/rpm-4.4.2.3/ChangeLog test2@aa.com < /usr/share/doc/clamav-0.98.5/ChangeLog
        ;;
    "12" )
        mutt -F /root/test4_muttrc -s "test" -a /usr/share/doc/rpm-4.4.2.3/ChangeLog test3@bb.com < /usr/share/doc/clamav-0.98.5/ChangeLog
        ;;
esac
