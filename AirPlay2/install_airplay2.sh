
#!/bin/busybox ash

. /etc/init.d/tc-functions
. /var/www/cgi-bin/pcp-functions

useBusybox
TARGET=`cat /etc/sysconfig/backup_device`

sudo -u tc tce-load -wi pcp-shairportsync.tcz avahi.tcz libavahi.tcz glib2.tcz pcp-libffmpeg.tcz libgcrypt.tcz pcp-libsoxr.tcz

cd /mnt/$TARGET/optional
rm pcp-shairportsync.tcz*
wget https://raw.githubusercontent.com/sam0402/pCP-addon/main/AirPlay2/pcp-shairportsync.tcz
wget https://raw.githubusercontent.com/sam0402/pCP-addon/main/AirPlay2/pcp-shairportsync.tcz.md5.txt
wget https://raw.githubusercontent.com/sam0402/pCP-addon/main/AirPlay2/pcp-shairportsync.tcz.dep
wget https://raw.githubusercontent.com/sam0402/pCP-addon/main/AirPlay2/libconfig_popt.tcz
wget https://raw.githubusercontent.com/sam0402/pCP-addon/main/AirPlay2/libconfig_popt.tcz.md5.txt
wget https://raw.githubusercontent.com/sam0402/pCP-addon/main/AirPlay2/libplist.tcz
wget https://raw.githubusercontent.com/sam0402/pCP-addon/main/AirPlay2/libplist.tcz.md5.txt
wget https://raw.githubusercontent.com/sam0402/pCP-addon/main/AirPlay2/libsodium.tcz
wget https://raw.githubusercontent.com/sam0402/pCP-addon/main/AirPlay2/libsodium.tcz.md5.txt

echo "Rebooting..."
sleep 3
pcp br
