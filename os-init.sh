#关闭防火墙
systemctl disable --now firewalld
#关闭selinux
sed -i 's/enforcing/disabled/g' /etc/selinux/config && setenforce 0
#调整内核参数
cat >> /etc/security/limits.conf <<EOF
*soft nproc 65535
*hard nproc 65535
* soft nofile 65535
* hardnofile 65535
EOF