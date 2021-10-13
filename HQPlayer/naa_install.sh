#!/bin/busybox ash

. /etc/init.d/tc-functions
. /var/www/cgi-bin/pcp-functions

useBusybox
TARGET=`cat /etc/sysconfig/backup_device`
cd /mnt/$TARGET
echo naa.tcz >>onboot.lst
cd optional
tce-load -i ca-certificates.tcz
wget https://raw.githubusercontent.com/sam0402/pCP-addon/main/HQPlayer/naa.tcz

pcp_write_var_to_config USER_COMMAND_3 "%2fusr%2fsbin%2fnetworkaudiod+%26%3b+taskset+-p+0x00000008+%24(pgrep+networkaudiod*)"
echo "Rebooting..."
sleep 3
pcp br
