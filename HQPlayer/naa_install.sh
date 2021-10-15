#!/bin/busybox ash

. /etc/init.d/tc-functions
. /var/www/cgi-bin/pcp-functions

useBusybox
TARGET=`cat /etc/sysconfig/backup_device`
cd /mnt/$TARGET
sed -i '/naa.tcz/d;/naa_arm64.tcz/d' onboot.lst
echo naa_arm64.tcz >>onboot.lst
cd optional
tce-load -i ca-certificates.tcz
wget https://raw.githubusercontent.com/sam0402/pCP-addon/main/HQPlayer/naa_arm64.tcz

pcp_write_var_to_config USER_COMMAND_3 "(networkaudiod+%26)%3b+taskset+-p+0x00000008+%24(pgrep+networkaudiod*)"
echo "Rebooting..."
sleep 3
pcp br
