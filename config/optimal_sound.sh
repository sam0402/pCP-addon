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
sed -i '/dialog.tcz/d' pcp.tcz.dep
echo 'libasound2.tcz' >pcp-squeezelite.tcz.dep

NUM=`grep -c 'taskset' /opt/bootlocal.sh`
if [ $NUM -eq 0 ]
then
  cat << 'EOL' >> /opt/bootlocal.sh

#--- Add by Sam0402
sleep 20
taskset -p 0x00000008 $(pgrep squeezelite*)
pkill -f udhcpc
sleep 60
umount /tmp/tcloop/uhubctl
umount /tmp/tcloop/libusb
umount /tmp/tcloop/libudev
sleep 90
umount /tmp/tcloop/alsa-utils
umount /tmp/tcloop/ncurses
[ `ps | grep -c 'sshd: tc'` -lt 3 ] && pkill -f ssh
umount /tmp/tcloop/ca-certificates
umount /tmp/tcloop/openssh
＃umount /tmp/tcloop/openssl
EOL
fi
echo "Rebooting..."
sleep 2
pcp br
