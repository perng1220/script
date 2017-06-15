#/bin/bash
filename=(`cut -d '"' -f 2 /var/log/mv_s3.err | cut -d "/" -f 2 | sort -u`)
arraylen=${#filename[@]}

for ((i=0;i<${arraylen};i++));
do
    recheck_file=(`grep ${filename[$i]} /root/image02.txt_list /root/image03.txt_list /root/image04.txt_list | cut -d ":" -f 2`)
    recheck_file_arraylen=${#recheck_file[@]}
    for ((j=0;j<${recheck_file_arraylen};j++));
    do
        if ! aws s3 ls s3://hoten-images${recheck_file[$j]} > /dev/null
        then
#            echo "${recheck_file[$j]} is not exist"
            aws s3 cp ${recheck_file[$j]} s3://hoten-images${recheck_file[$j]} >> /var/log/mv_s3_thumb.log 2>> /var/log/mv2_s3_thumb.err
        fi
    done
done
