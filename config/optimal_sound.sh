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
taskset -p 0x00000008 $(pgrep squeezelite*)
sleep 60
umount /tmp/tcloop/uhubctl
umount /tmp/tcloop/libusb
umount /tmp/tcloop/libudev
sleep 210
umount /tmp/tcloop/openssh
umount /tmp/tcloop/openssl
umount /tmp/tcloop/alsa-utils
umount /tmp/tcloop/ca-certificate
umount /tmp/tcloop/ncurses
umount /tmp/tcloop/dialog
EOL

echo "Rebooting..."
sleep 2
pcp br
