#!/bin/bash
export PATH=/bin:/sbin:/usr/bin:/usr/sbin
#save_path=~/appex/nistnet
save_path=~

reset
if [ -z "$1" ];then
	echo "Please enter filename"
	exit 1
fi

if [ ! -e "$save_path" ];then
	mkdir -p $save_path
fi

if [ -e "$save_path/$1" ];then
	rm -f $save_path/test$1
fi

for ((i=1;i<=10;i++))
do
	j=$(($RANDOM%100+1))
#	echo -e "\n" >> result.log && echo Test$i: >> $1 
	ab -k -c 500 -n 1000 http://172.16.0.1/file/file1m$j | tee -a $save_path/$1
	sleep 5
done
