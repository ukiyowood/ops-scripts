mkdir /mnt/iso
mount /dev/sr0 /mnt/iso

mkdir ~/yum.repo.bak && mv /etc/yum.repos.d/* ~/yum.repo.bak/ && touch /etc/yum.repos.d/local.repo
cat > /etc/yum.repos.d/local.repo <<EOF
[iso]
name=ISO LOCAL REPO
baseurl=file:///mnt/iso
gpgcheck=false
enabled=true
EOF
yum makecache
echo '/dev/sr0 /mnt/iso iso9660 defaults 0 0' >> /etc/fstab
echo "自动挂载完毕..."