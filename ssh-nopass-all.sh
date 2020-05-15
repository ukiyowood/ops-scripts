#!/bin/bash

#安装expect组件
yum install -y expect

#设置主机名和密码
PWD=nccloud001
HOSTS="10.10.18.231 10.10.18.232"

#生成密钥
key_generate() {
	expect -c "set timeout -1;
		spawn ssh-keygen -t rsa;
		expect {
			{Enter file in which to save the key*} {send -- \r;exp_continue}
            		{Enter passphrase*} {send -- \r;exp_continue}
            		{Enter same passphrase again:} {send -- \r;exp_continue}
            		{Overwrite (y/n)*} {send -- n\r;exp_continue}
            		eof             {exit 0;}
		};"
}

#远程拷贝密钥
auto_ssh_copy_id () {
	expect -c "set timeout -1;
        	spawn ssh-copy-id -i $HOME/.ssh/id_rsa.pub root@$1;
            	expect {
                	{Are you sure you want to continue connecting *} {send -- yes\r;exp_continue;}
                	{*password:} {send -- $2\r;exp_continue;}
                	eof {exit 0;}
            };"
}

#开始执行...
key_generate

for host in $HOSTS
do
	auto_ssh_copy_id $host $PWD
done

echo "run end!!!"

