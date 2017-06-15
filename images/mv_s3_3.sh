#/bin/bash
filelist="/root/image04.txt"
filename=(`awk '{ print $4 }' $filelist | tr "\n" " "`)
arraylen=${#filename[@]}

#for ((i=0;i<${arraylen};i++));
#do
#    locate ${filename[$i]} | tee -a ${filelist}_list
#done

for j in `cat ${filelist}_list`
do
    aws s3 mv s3://hoten-images/images/$(basename $j) s3://hoten-images${j} --grants read=uri=http://acs.amazonaws.com/groups/global/AllUsers full=id=9163737ac234c9a520065fcd879a50ea22aaa6f41faa4a36119bafc7ed1ae3c1 >> /var/log/mv_s3.log 2>> /var/log/mv_s3.err
done
