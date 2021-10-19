
#!/bin/busybox ash

. /etc/init.d/tc-functions
. /var/www/cgi-bin/pcp-functions

useBusybox
TARGET=`cat /etc/sysconfig/backup_device`
cd /mnt/$TARGET
sed -i '/hqplayer.tcz/d' onboot.lst
echo hqplayer.tcz >>onboot.lst
cd optional
tce-load -i ca-certificates.tcz
wget https://raw.githubusercontent.com/sam0402/pCP-addon/main/HQPlayer/hqplayer.tcz
echo 'http://repo.tinycorelinux.net/' >/opt/tcemirror
sed -i '/ldconfig/d;/hqplayerd/d' /opt/bootlocal.sh
echo 'ldconfig' >>/opt/bootlocal.sh
echo 'sudo -u tc hqplayerd &' >>/opt/bootlocal.sh
echo 'taskset -p 0x00000008 $(pgrep hqplayerd*)' >>/opt/bootlocal.sh
mkdir -p ~/hqplayer/modules-load.d
mkdir -p ~/hqplayer/udev/rules.d
cd ~/hqplayer
wget https://raw.githubusercontent.com/sam0402/pCP-addon/main/HQPlayer/hqplayerd.xml
wget https://raw.githubusercontent.com/sam0402/pCP-addon/main/HQPlayer/hqplayerd-auth.xml
echo "Rebooting..."
sleep 3
pcp br
