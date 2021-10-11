#!/bin/busybox ash

. /etc/init.d/tc-functions
. /var/www/cgi-bin/pcp-functions

useBusybox
TARGET=`cat /etc/sysconfig/backup_device`
cd /mnt/$TARGET
wget https://raw.githubusercontent.com/sam0402/pCP-addon/main/config/mydata8_fifo.tgz
mv mydata8_fifo.tgz mydata.tgz
ln -s /mnt/$TARGET/tce/squeezelite-pcm squeezelite
wget -O - https://raw.githubusercontent.com/sam0402/pCP-addon/main/config/optimal_sound.sh | sudo sh
