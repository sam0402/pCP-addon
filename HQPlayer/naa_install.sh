#!/bin/busybox ash

. /etc/init.d/tc-functions
. /var/www/cgi-bin/pcp-functions

useBusybox
TARGET=`cat /etc/sysconfig/backup_device`
cd /mnt/$TARGET
echo naa.tcz >>onboot.lst
cd optional
wget https://raw.githubusercontent.com/sam0402/pCP-addon/main/HQPlayer/naa.tcz

pcp_write_var_to_config USER_COMMAND_3 ""
echo "Rebooting..."
sleep 3
pcp br
