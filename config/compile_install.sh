#!/bin/busybox ash

. /etc/init.d/tc-functions
. /var/www/cgi-bin/pcp-functions

useBusybox
TARGET=`cat /etc/sysconfig/backup_device`
m1
c1
wget modules-5.13.1-pcpEVL.gz
wget kernel5131v8.img
wget config.txt
cd /mnt/$TARGET
echo 'http://repo.tinycorelinux.net/' >/opt/tcemirror
tce-load -wi squashfs-tools openssl-dev libelf-dev libudev-dev libpci-dev bash compiletc autoconf libasound-dev 
cd optional
wget filesystems-5.13.1-pcpEVL.tcz
wget alsa-modules-5.13.1-pcpEVL.tcz
wget alsa-modules-5.13.1-pcpEVL.tcz.md5
sed -i '/alsa.tcz/d;/alsa-utils.tcz/d;/rng-tools.tcz/d;/dialog.tcz/d' pcp.tcz.dep

sudo adduser sam
cd /home
sudo rm -rf sam
sudo mount /dev/sda2 /mnt/sda2
ln -s /mnt/sda2/home/ubuntu sam
cd /etc
sudo chmod u+w sudoers
sudo sed -i 's/tc/tc,sam/g' sudoers
pcp bu
