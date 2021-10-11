#!/bin/busybox ash

. /etc/init.d/tc-functions
. /var/www/cgi-bin/pcp-functions

useBusybox
TARGET=`cat /etc/sysconfig/backup_device`
cd /mnt/$TARGET
wget https://raw.githubusercontent.com/sam0402/pCP-addon/main/config/mydata8_fifo.tgz
mv mydata8_fifo.tgz mydata.tgz
ln -s /mnt/$TARGET/tce/squeezelite-pcm squeezelite
# pcp_write_var_to_config USER_COMMAND_3 "sleep+180%3b%5b+%60ps+%7c+grep+-c+%27sshd%3a+tc%27%60+-lt+3+%5d+%26%26+(pkill+-f+ssh%3bumount+%2ftmp%2ftcloop%2fca-certificates%3bumount+%2ftmp%2ftcloop%2fopenssh)"
wget -O - https://raw.githubusercontent.com/sam0402/pCP-addon/main/config/optimal_sound.sh | sudo sh
