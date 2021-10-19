
#!/bin/busybox ash

. /etc/init.d/tc-functions
. /var/www/cgi-bin/pcp-functions

useBusybox
TARGET=`cat /etc/sysconfig/backup_device`
cd /mnt/$TARGET
sed -i '/hqplayer.tcz/d;/pcp-libflac.tcz/d' onboot.lst
echo hqplayer.tcz >>onboot.lst
echo pcp-libflac.tcz >>onboot.lst

cd optional
sed -i '/pcp-squeezelite.tcz/d;/rng-tools.tcz/d;/dialog.tcz/d' pcp.tcz.dep
sed -i '/glib2.tcz/d' libudev.tcz.dep
tce-load -i ca-certificates.tcz
wget https://raw.githubusercontent.com/sam0402/pCP-addon/main/HQPlayer/hqplayer.tcz

#echo 'http://repo.tinycorelinux.net/' >/opt/tcemirror
sed -i '11,$d' /opt/bootlocal.sh
if [ `grep -c 'hqplayerd' /opt/bootlocal.sh` -eq 0 ]
then
  cat << 'EOL' >> /opt/bootlocal.sh
#--- Add by Sam0402
ldconfig
sudo -u tc hqplayerd &
sleep 10
taskset -p 0x00000008 $(pgrep hqplayerd*)
#--- Add by Sam0402
EOL
fi

# tc home
mkdir -p ~/hqplayer/modules-load.d
mkdir -p ~/hqplayer/udev/rules.d
cd ~/hqplayer
wget https://raw.githubusercontent.com/sam0402/pCP-addon/main/HQPlayer/hqplayerd.xml
wget https://raw.githubusercontent.com/sam0402/pCP-addon/main/HQPlayer/hqplayerd-auth.xml
pcp_write_var_to_config USER_COMMAND_1 "%23sleep+60%3buhubctl+-l2+-a0%3bsleep+120%3bpkill+-f+httpd%3bumount+%2ftmp%2ftcloop%2fpcp-8.0.0-www"
pcp_write_var_to_config USER_COMMAND_2 "%23sleep+180%3bif+%5b+%60pgrep+ssh+%7c+wc+-l%60+-lt+3+%5d%3bthen+pkill+-f+ssh%3bfi"
pcp_write_var_to_config USER_COMMAND_3 ""

echo "Rebooting..."
sleep 3
pcp br
