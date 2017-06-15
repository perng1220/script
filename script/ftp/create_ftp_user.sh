#!/bin/bash
#Description:
#create ftp user

export PATH=/bin:/sbin:/usr/bin:/usr/sbin

create_customer ()
{
    read -p "Input customer name: " customer
    if [ -z "$customer" ] || id $customer > /dev/null 2>&1; then
        echo "Error: Customer name is empty or exist"
        exit 6
    fi
    read -s -p "Input customer password: " password
    echo ""
    read -s -p "Confirm password: " confirm_pwd
    if [ -z "$password" ] || [ "$password" != "$confirm_pwd" ]; then
        echo ""
        echo "Password does not match the confirm password or is empty."
        exit 4
    fi
    echo ""
    read -p "Project owner: " owner
    if [ -z "$owner" ] || ! id $owner > /dev/null 2>&1; then
        echo "Error: $owner is not exist or empty"
        exit 2
    fi
    useradd -m -d /var/ftp/$owner/$customer -s /sbin/nologin $customer
    usermod -a -G $customer $owner
    usermod -a -G $customer chief
    echo $password | passwd --stdin $customer
    chmod 2770 /var/ftp/$owner/$customer
}

create_staff ()
{
    read -p "Input staff name: " staff
    if [ -z "$staff" ] || id $staff > /dev/null 2>&1; then
        echo "Error: Staff name is empty or exist"
        exit 3
    fi
    read -s -p "Input staff password: " password
    echo ""
    read -s -p "Confirm password: " confirm_pwd
    echo ""
    if [ -z "$password" ] || [ "$password" != "$confirm_pwd" ]; then
        echo ""
        echo "Password does not match the confirm password or is empty."
        exit 1
    fi
    useradd -m -d /var/ftp/$staff -s /sbin/nologin $staff
    usermod -a -G $staff chief
    chmod 2775 /var/ftp/$staff
    echo $password | passwd --stdin $staff
}

echo "1.Create customer account"
echo "2.Create staff account"
read -p "Choice 1 or 2: " choice

case "$choice" in
    "1" )
        create_customer
        ;;
    "2" )
        create_staff
        ;;
    * )
        echo "Error: Please input 1 or 2"
        exit 1
        ;;
esac
