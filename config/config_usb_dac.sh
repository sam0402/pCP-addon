#!/bin/busybox ash

. /etc/init.d/tc-functions
. /var/www/cgi-bin/pcp-functions

useBusybox
TARGET=`cat /etc/sysconfig/backup_device`
cd /mnt/$TARGET
wget https://raw.githubusercontent.com/sam0402/pCP-addon/main/config/mydata8_usb.tgz
mv mydata8_usb.tgz mydata.tgz
ln -s /mnt/$TARGET/tce/squeezelite-dsd squeezelite
sed -i '/rpi-vc.tcz/d;/ntfs-3g.tcz/d' onboot.lst
cd optional
sed -i '/rng-tools.tcz/d;/dialog.tcz/d' pcp.tcz.dep
echo 'libasound2.tcz' >pcp-squeezelite.tcz.dep
pcp_write_var_to_config USER_COMMAND_1 "uhubctl+-l2+-a+0%3buhubctl+-l2+-p2+-a+1%3bsleep+120%3bpkill+-f+httpd%3bumount+%2ftmp%2ftcloop%2fpcp-8.0.0-www"

sed -i '11,$d' /opt/bootlocal.sh
if [ `grep -c 'taskset' /opt/bootlocal.sh` -eq 0 ]
then
  cat << 'EOL' >> /opt/bootlocal.sh
#--- Add by Sam0402
taskset -p 0x00000008 $(pgrep squeezelite*)
pkill -f udhcpc
umount /tmp/tcloop/uhubctl /tmp/tcloop/libusb /tmp/tcloop/libudev
umount /tmp/tcloop/ncurses /tmp/tcloop/alsa-utils /tmp/tcloop/ca-certificates
#--- Add by Sam0402
EOL
fi
echo "Rebooting..."
sleep 2
pcp br
