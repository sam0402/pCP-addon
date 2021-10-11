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
echo 'libasound2.tcz' >pcp-squeezelite.tcz.dep
pcp_write_var_to_config USER_COMMAND_1 "%23sleep+60%3buhubctl+-l+1-1+-a+0%3bsleep+120%3bpkill+-f+httpd%3bumount+%2ftmp%2ftcloop%2fpcp-8.0.0-www"
pcp_write_var_to_config USER_COMMAND_2 "sleep+180%3bif+%5b+%60ps+%7c+grep+-c+%27sshd%3a+tc%27%60+-lt+3+%5d%3bthen+(pkill+-f+ssh%3bumount+%2ftmp%2ftcloop%2fopenssh)%3bif"
sed -i '11,$d' /opt/bootlocal.sh
if [ `grep -c 'taskset' /opt/bootlocal.sh` -eq 0 ]
then
  cat << 'EOL' >> /opt/bootlocal.sh

#--- Add by Sam0402
sleep 20
taskset -p 0x00000008 $(pgrep squeezelite*)
pkill -f udhcpc
sleep 60
umount /tmp/tcloop/uhubctl /tmp/tcloop/libusb /tmp/tcloop/libudev
umount /tmp/tcloop/ncurses /tmp/tcloop/alsa-utils /tmp/tcloop/ca-certificates
#--- Add by Sam0402
EOL
fi
echo "Rebooting..."
sleep 2
pcp br
