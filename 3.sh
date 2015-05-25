#!/bin/bash
export PATH=/bin:/sbin:/usr/bin:/usr/sbin

csv_file=$1
db_name=phone
table_name=allnum
while (true)
do 
    data=`head -n 1 $csv_file`
    if [ -n "$data" ]; then
#        vat_number=`echo $data | cut -d ";" -f 1`
        company=`echo $data | cut -d ";" -f 1`
#        person_in_charge=`echo $data | cut -d ";" -f 3`
        address=`echo $data | cut -d ";" -f 2`
        company_tel1=`echo $data | cut -d ";" -f 3`
#        company_tel1_ext=`echo $data | cut -d ";" -f 6`
        company_tel2=`echo $data | cut -d ";" -f 4`
#        company_tel2_ext=`echo $data | cut -d ";" -f 8`
        fax=`echo $data | cut -d ";" -f 5`
        website=`echo $data | cut -d ";" -f 6`
#        contact=`echo $data | cut -d ";" -f 10`
#        contact_tel=`echo $data | cut -d ";" -f 11`
#        contact_tel_ext=`echo $data | cut -d ";" -f 12`
#        contact_mobile=`echo $data | cut -d ";" -f 13`
        mail=`echo $data | cut -d ";" -f 7`
#        sales=`echo $data | cut -d ";" -f 15`
        if [ -z "$company_tel2" ]; then
            query=`mysql -uroot -e "use $db_name;select company,company_tel1 from $table_name where company='$company' or company_tel1='$company_tel1'" || exit 1`
            if [ -n "$query" ]; then
#                echo "$vat_number;$company;$person_in_charge;$address;$company_tel1;$company_tel1_ext;$company_tel2;$company_tel2_ext;$fax;$contact;$contact_tel;$contact_tel_ext;$contact_mobile;$mail;$sales" >> ${1}_match.csv
                echo "$company;$address;$company_tel1;$company_tel2;$fax;$website;$mail" >> ${1}_match
                sed -i '1d' $csv_file
            else
#                echo "$vat_number;$company;$person_in_charge;$address;$company_tel1;$company_tel1_ext;$company_tel2;$company_tel2_ext;$fax;$contact;$contact_tel;$contact_tel_ext;$contact_mobile;$mail;$sales" >> ${1}_mismatch.csv
                echo "$company;$address;$company_tel1;$company_tel2;$fax;$website;$mail" >> ${1}_mismatch
                sed -i '1d' $csv_file
            fi
        else
            query=`mysql -uroot -e "use $db_name;select company,company_tel1,company_tel2 from $table_name where company='$company' or company_tel1='$company_tel1' or company_tel2='$company_tel2'" || exit 1`
            if [ -n "$query" ]; then
#                echo "$vat_number;$company;$person_in_charge;$address;$company_tel1;$company_tel1_ext;$company_tel2;$company_tel2_ext;$fax;$contact;$contact_tel;$contact_tel_ext;$contact_mobile;$mail;$sales" >> ${1}_match.csv
                echo "$company;$address;$company_tel1;$company_tel2;$fax;$website;$mail" >> ${1}_match
                sed -i '1d' $csv_file
            else
#                echo "$vat_number;$company;$person_in_charge;$address;$company_tel1;$company_tel1_ext;$company_tel2;$company_tel2_ext;$fax;$contact;$contact_tel;$contact_tel_ext;$contact_mobile;$mail;$sales" >> ${1}_mismatch.csv
                echo "$company;$address;$company_tel1;$company_tel2;$fax;$website;$mail" >> ${1}_mismatch
                sed -i '1d' $csv_file
            fi
        fi
    else
        exit 2
    fi
done
