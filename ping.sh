#/bin/bash

##My Ping CMD

rm results.iplist > /dev/null 2>&1

preIP=`echo $1 | awk -F . '{print $1"."$2"."$3"."}'`
for a in `seq -s ' ' 1 254`
do
        IP=$preIP$a

        ping -c 1 $IP > /dev/null 2>&1
        if [ $? -ne 0 ];then
                echo $IP >> results.iplist
        fi
done
echo ping over...
