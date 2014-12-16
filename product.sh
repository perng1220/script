#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin
db_host=192.168.122.12
db_user=root
db_name=db_ecbtobutf8
id=`cat id.txt`

for i in $id
do
    declare -i product_list=0
    declare -i product_list_total=0
    declare -i selling_leads=0
    declare -i selling_leads_total=0
    mdaid=`mysql -h $db_host -u$db_user -e "select mdaid from ${db_name}.ec_m_detailedinfo where loginname='$i'" | sed 1d`
    if [ -z "$mdaid" ]; then
        continue
    fi
    sccode1=`mysql -h $db_host -u$db_user -e "SELECT DISTINCT(sccode1) FROM ${db_name}.ec_pro_whouse WHERE mdaid='$mdaid' AND isvalid='1'" | sed 1d`
    for j in $sccode1
    do
        product_list=`mysql -h $db_host -u$db_user -e "SELECT COUNT(*) FROM ${db_name}.ec_pro_whouse WHERE mdaid=$mdaid AND sccode1='$j' AND isvalid='1'" | sed 1d`
        product_list_total=product_list_total+product_list
    done

    cspccode=`mysql -h $db_host -u$db_user -e "SELECT DISTINCT(cspccode) FROM ${db_name}.ec_c_sellprocatalog AS b, ${db_name}.ec_pro_selling AS a WHERE a.mdaid='$mdaid' AND a.psaid=b.psaid AND a.isvalid='1'" | sed 1d`
    for k in $cspccode
    do
        selling_leads=`mysql -h $db_host -u$db_user -e "SELECT COUNT(*) FROM ${db_name}.ec_c_sellprocatalog AS b, ${db_name}.ec_pro_selling AS a WHERE a.mdaid='$mdaid' AND b.cspccode='$k' AND a.psaid=b.psaid AND a.isvalid='1'" | sed 1d`
        selling_leads_total=selling_leads_total+selling_leads
    done

    companyname=`mysql -h $db_host -u$db_user -e "select companyname from ${db_name}.ec_m_detailedinfo where loginname='$i'" | sed 1d`
    mail_total=`mysql -h $db_host -u$db_user -e "select count(*) from ${db_name}.ec_inq_basket where tocorp='$companyname'" | sed 1d`

echo "$i,$product_list_total,$selling_leads_total,$mail_total" >> product.csv
done
