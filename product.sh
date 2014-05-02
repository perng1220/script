#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin
db_host=192.168.122.12
db_user=root
db_name=db_ecbtobutf8
id=20060000448

function product() {
    declare -i product_list
    declare -i product_list_total
    sccode1=`mysql -h $db_host -u$db_user -e "SELECT DISTINCT(sccode1) FROM ${db_name}.ec_pro_whouse WHERE mdaid='$mdaid' AND isvalid='1'" | sed 1d`
    echo $sccode1
    for i in $sccode1
    do
        product_list=`mysql -h $db_host -u$db_user -e "SELECT COUNT(*) FROM ${db_name}.ec_pro_whouse WHERE mdaid=$mdaid AND sccode1='$i' AND isvalid='1'" | sed 1d
`
        product_list_total=product_list_total+product_list
    done
    echo $product_list_total
}

function selling() {
    declare -i selling_leads
    declare -i selling_leads_total
    cspccode=`mysql -h $db_host -u$db_user -e "SELECT DISTINCT(cspccode) FROM ${db_name}.ec_c_sellprocatalog AS b, ${db_name}.ec_pro_selling AS a WHERE a.mdaid='$mdaid' AND a.psaid=b.psaid AND a.isvalid='1'" | sed 1d`
    echo $cspccode
    for i in $cspccode
    do
        selling_leads=`mysql -h $db_host -u$db_user -e "SELECT COUNT(*) FROM ${db_name}.ec_c_sellprocatalog AS b, ${db_name}.ec_pro_selling AS a WHERE a.mdaid='$mdaid' AND b.cspccode='$i' AND a.psaid=b.psaid AND a.isvalid='1'" | sed 1d`
        echo $selling_leads
        selling_leads_total=selling_leads_total+selling_leads
    done
    echo $selling_leads_total
}

mdaid=`mysql -h $db_host -u$db_user -e "select mdaid from ${db_name}.ec_m_detailedinfo where loginname='$id'" | sed 1d`
echo $mdaid
product
selling

