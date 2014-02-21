#!/bin/bash
export PATH=/bin:/sbin:/usr/bin:/usr/sbin

create_customer ()
{
    read -p "Input customer's name: " customer
    read -s -p "Input customer's password: " c_password
    echo ""
    read -s -p "Confirm password: " confirm_pwd
    if [ "$c_password" != "$confirm_pwd" ]; then
        echo ""
        echo "Password does not match the confirm password."
        exit 6
    fi
    echo ""
    read -p "Project owner: " owner
    if id $customer > /dev/null 2>&1; then
        echo "Error: $owner is not exist"
        exit 4
    fi
    if [ -n "$customer" ] && [ -n "$c_password" ] && ! id $customer > /dev/null 2>&1; then
        useradd -m -d /var/ftp/$owner/$customer $customer
        usermod -a -G $customer $owner
        usermod -a -G $customer chief
        echo $c_password | passwd --stdin $customer
        chmod 2770 /var/ftp/$owner/$customer
    else
        echo "Error: Customer's name is empty or exist"
        exit 2
    fi
}

create_staff ()
{
    read -p "Input staff's name: " staff
    read -s -p "Input staff's password: " s_password
    echo ""
    read -s -p "Confirm password: " confirm_pwd
    if [ "$s_password" != "$confirm_pwd" ]; then
        echo ""
        echo "Password does not match the confirm password."
        exit 5
    fi
    if [ -n "$staff" ] && [ -n "$s_password" ] && ! id $staff > /dev/null 2>&1; then
        useradd -m -d /var/ftp/$staff $staff
        usermod -a -G $staff chief
        chmod 2775 /var/ftp/$staff
        echo $s_password | passwd --stdin $staff
    else
        echo "Error: Staff's name is empty or exist"
        exit 3
    fi
}

echo "1.Create customer's account"
echo "2.Create staff's account"
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
