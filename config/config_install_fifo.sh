#!/bin/busybox ash

. /etc/init.d/tc-functions
. /var/www/cgi-bin/pcp-functions

useBusybox
TARGET=`cat /etc/sysconfig/backup_device`
cd /mnt/$TARGET
tce-load -i ca-certificates.tcz
wget https://raw.githubusercontent.com/sam0402/pCP-addon/main/config/mydata8_fifo.tgz
mv mydata8_fifo.tgz mydata.tgz
ln -s /mnt/$TARGET/tce/squeezelite-pcm squeezelite
sed -i '/rpi-vc.tcz/d;/ntfs-3g.tcz/d' onboot.lst
cd optional
sed -i '/alsa-utils.tcz/d;/rng-tools.tcz/d;/dialog.tcz/d' pcp.tcz.dep
sed -i '/glib2.tcz/d' libudev.tcz.dep
echo 'libasound2.tcz' >pcp-squeezelite.tcz.dep
pcp_write_var_to_config USER_COMMAND_1 "uhubctl+-l2+-a0%3Bsleep+180%3Bpkill+-f+httpd%3b%5b+%60pgrep+ssh+%7c+wc+-l%60+-lt+3+%5d+%26%26+pkill+-f+ssh"
pcp_write_var_to_config USER_COMMAND_2 ""
pcp_write_var_to_config USER_COMMAND_3 ""

sed -i '11,$d' /opt/bootlocal.sh
if [ `grep -c 'taskset' /opt/bootlocal.sh` -eq 0 ]
then
  cat << 'EOL' >> /opt/bootlocal.sh
#--- Add by Sam0402
taskset -p 0x00000008 $(pgrep squeezelite*)
pkill -f udhcpc
umount /tmp/tcloop/uhubctl /tmp/tcloop/libusb /tmp/tcloop/libudev
#--- Add by Sam0402
EOL
fi
