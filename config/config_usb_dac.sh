#!/bin/busybox ash

. /etc/init.d/tc-functions
. /var/www/cgi-bin/pcp-functions

useBusybox
TARGET=`cat /etc/sysconfig/backup_device`
cd /mnt/$TARGET
wget https://raw.githubusercontent.com/sam0402/pCP-addon/main/config/mydata8_usb.tgz
mv mydata8_usb.tgz mydata.tgz
ln -s /mnt/$TARGET/tce/squeezelite-dsd squeezelite
sed -i '/rpi-vc.tcz/d' onboot.lst
cd optional
sed -i '/rng-tools.tcz/d' pcp.tcz.dep
echo 'libasound2.tcz' >pcp-squeezelite.tcz.dep
echo "Rebooting..."
sleep 2
pcp rb
