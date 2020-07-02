#!/bin/bash

# 初始化系统，用于安装标准盘前设置（幂等）
# 包含功能：
#     1. 挂载磁盘/dev/vdb /data
#     2. 修改主机名 
#     3. 安装依赖包
#     4. 配置系统
#     5. 设置中文字符集
#     6. 打印字体安装
#     7. 设置jdk 

echo "****开始执行脚本: init.sh****"
echo "++++开始配置本地yum源: mnt.repo++++"
if [ "$(mount | grep mnt | grep /dev/sr0)" == "" ];then
    echo "yum源未配置，开始挂载配置"
    mount /dev/sr0 /mnt && rm -rf /etc/yum.repos.d/*
cat <<EOF> /etc/yum.repos.d/mnt.repo
[mnt]
name=mnt
baseurl=file:///mnt
gpgcheck=0
enabled=1
EOF
    echo "yum源配置完成"
else
    echo "yum源已配置"

echo "++++yum 安装依赖包++++"
yum install -y libXrender libXft libXtst xorg-x11-xauth kde-l10n-Chinese liberation-fonts-common cjkuni-uming-fonts \
libgtk-x11* libXtst.so* xorg-x11-xauth kde-l10n-Chinese liberation-fonts-common cjkuni-uming-fonts
yum -y  install vim  net-tools samba  wget git expect zip unzip
echo  -e "++++软件安装完毕++++"

echo "+++++调整系统参数++++"
cat /etc/security/limits.conf | tail -n 4 | grep '#' > /dev/null 2>&1
if [ $? -eq 0 ];then
    echo -e "* soft nproc 65535\n* hard nproc 65535\n* soft nofile 65535\n* hard nofile 65535" >>/etc/security/limits.conf;rm -rf  /etc/security/limits.d/20-nproc.conf ;ulimit -SHn 102400
else
    echo -e "\033[43;34m ****limits.conf文件已经配置，无需处理**** \033[0m"
fi

echo "++++防火墙和selinux设置++++"
systemctl disable --now firewalld
setenforce 0 && sed -i 's/enforcing/disabled/g' /etc/selinux/config



