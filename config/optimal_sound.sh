#!/bin/busybox ash

. /etc/init.d/tc-functions
. /var/www/cgi-bin/pcp-functions

useBusybox
TARGET=`cat /etc/sysconfig/backup_device`
cd /mnt/$TARGET
ln -s /mnt/$TARGET/tce/squeezelite-dsd squeezelite
sed -i '/rpi-vc.tcz/d;/ntfs-3g.tcz/d' onboot.lst
cd optional
sed -i '/rng-tools.tcz/d;/dialog.tcz/d' pcp.tcz.dep
sed -i '/glib2.tcz/d' libudev.tcz.dep
echo 'libasound2.tcz' >pcp-squeezelite.tcz.dep
pcp_write_var_to_config USER_COMMAND_1 "%23sleep+60%3buhubctl+-l2+-a0%3bsleep+120%3bpkill+-f+httpd"
pcp_write_var_to_config USER_COMMAND_2 "sleep+180%3bif+%5b+%60pgrep+ssh+%7c+wc+-l%60+-lt+3+%5d%3bthen+pkill+-f+ssh%3bfi"

sed -i '11,$d' /opt/bootlocal.sh
if [ `grep -c 'taskset' /opt/bootlocal.sh` -eq 0 ]
then
  cat << 'EOL' >> /opt/bootlocal.sh

#--- Add by Sam0402
taskset -p 0x00000008 $(pgrep squeezelite*)
pkill -f udhcpc
umount /tmp/tcloop/uhubctl /tmp/tcloop/libusb /tmp/tcloop/libudev
umount /tmp/tcloop/ncurses /tmp/tcloop/alsa-utils
#--- Add by Sam0402
EOL
fi
echo "Rebooting..."
sleep 2
pcp br
