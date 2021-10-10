#!/bin/busybox ash

. /etc/init.d/tc-functions
. /var/www/cgi-bin/pcp-functions

useBusybox
TARGET=`cat /etc/sysconfig/backup_device`
cd /mnt/$TARGET
ln -s /mnt/$TARGET/tce/squeezelite-dsd squeezelite
sed -i '/rpi-vc.tcz/d' onboot.lst
sed -i '/ntfs-3g.tcz/d' onboot.lst
cd optional
sed -i '/rng-tools.tcz/d' pcp.tcz.dep
echo 'libasound2.tcz' >pcp-squeezelite.tcz.dep

cat << 'EOL' >> /opt/bootlocal.sh
sleep 30
sudo taskset -p 0x00000008 $(pgrep squeezelite*)
sleep 60
sudo umount /tmp/tcloop/uhubctl
sudo umount /tmp/tcloop/libusb
sudo umount /tmp/tcloop/libudev
sleep 210
sudo umount /tmp/tcloop/openssh
sudo umount /tmp/tcloop/openssl
sudo umount /tmp/tcloop/alsa-utils
sudo umount /tmp/tcloop/ca-certificate
sudo umount /tmp/tcloop/ncurses
sudo umount /tmp/tcloop/dialog
EOL

echo "Rebooting..."
sleep 2
pcp br
