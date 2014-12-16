#!/bin/bash
export PATH=/bin:/sbin:/usr/bin:/usr/sbin

csv_file=$1
db_name=phone
table_name=allnum
while (true)
do 
    data=`head -n 1 $csv_file`
    if [ -n "$data" ]; then
        vat_number=`echo $data | cut -d ";" -f 1`
        company=`echo $data | cut -d ";" -f 2`
#        person_in_charge=`echo $data | cut -d ";" -f 3`
        address=`echo $data | cut -d ";" -f 7`
        company_tel1=`echo $data | cut -d ";" -f 3`
#        company_tel1_ext=`echo $data | cut -d ";" -f 6`
#        company_tel2=`echo $data | cut -d ";" -f 3`
#        company_tel2_ext=`echo $data | cut -d ";" -f 8`
        fax=`echo $data | cut -d ";" -f 4`
        website=`echo $data | cut -d ";" -f 5`
#        contact=`echo $data | cut -d ";" -f 10`
#        contact_tel=`echo $data | cut -d ";" -f 11`
#        contact_tel_ext=`echo $data | cut -d ";" -f 12`
#        contact_mobile=`echo $data | cut -d ";" -f 13`
        mail=`echo $data | cut -d ";" -f 6`
#        sales=`echo $data | cut -d ";" -f 15`
        mysql -uroot -e "use $db_name;insert into $table_name (vat_number, company, person_in_charge, address, company_tel1, company_tel1_ext, company_tel2, company_tel2_ext, fax, website, contact, contact_tel, contact_tel_ext, contact_mobile, mail, sales, date, platform, inuse) values ('$vat_number', '$company', '$person_in_charge', '$address', '$company_tel1', '$company_tel1_ext', '$company_tel2', '$company_tel2_ext', '$fax', '$website', '$contact', '$contact_tel', '$contact_tel_ext', '$contact_mobile', '$mail', '$sales', '', 'B2B', 'Y')" || exit 1

        sed -i '1d' $csv_file
    else
        exit 2
    fi
done
