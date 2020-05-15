#!/bin/bash

##手动配置远程主机时间同步

##前提是先配置好ssh免密登录

#直接定义IP列表
#HOSTS="10.10.18.231 10.10.18.232 10.10.18.233 10.10.18.234 10.10.18.235 10.10.18.236"

#从ip列表文件读取
for host in `cat ip.list`
do
        NOW=`date "+%Y-%m-%d %H:%M:%S"`
        echo "now=$NOW"
        ssh $host "date -s '$NOW'"
done

