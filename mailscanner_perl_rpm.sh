#!/bin/bash
export PATH=/bin:/sbin:/usr/bin:/usr/sbin

perl_rpm_list=( File-Spec ExtUtils-MakeMaker Pod-Escapes Pod-Simple Test-Simple Math-BigInt Math-BigRat bignum MIME-Base64 TimeDate Pod-Simple Pod-Escapes Pod-Simple Test-Harness Test-Simple Test-Pod IO IO-stringy MailTools File-Temp HTML-Tagset HTML-Parser Convert-BinHex MIME-tools Convert-TNEF Compress-Zlib Compress-Raw-Zlib Archive-Zip Scalar-List-Utils Storable DBI DBD-SQLite Getopt-Long Time-HiRes Filesys-Df Net-CIDR Net-IP Sys-Hostname-Long Sys-Syslog Digest-MD5 Digest-SHA1 Digest-HMAC Net-DNS OLE-Storage_Lite Sys-SigAction )

for ((i=0;i<${#perl_rpm_list[*]};i++))
do
    yum list perl-${perl_rpm_list[$i]}
    #echo perl-${perl_rpm_list[$i]}
done
