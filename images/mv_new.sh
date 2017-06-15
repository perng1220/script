#!/bin/bash
export PATH=/bin:/sbin:/usr/bin:/usr/sbin

for i in new
do
    while (true)
    do 
        filename=`head -n 1 $i`
        aws s3 cp "$filename" "s3://hoten-images${filename}" --grants read=uri=http://acs.amazonaws.com/groups/global/AllUsers full=id=9163737ac234c9a520065fcd879a50ea22aaa6f41faa4a36119bafc7ed1ae3c1 >> /var/log/mv_new.log 2>> /var/log/mv_new.err
        sed -i '1d' $i
        if [ ! -s "$i" ];then
          break;
        fi
    done
done
