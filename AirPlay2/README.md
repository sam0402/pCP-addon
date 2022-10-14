Script to install Airplay2 on piCorePlayer OS

1. Switch the Shairport-sync to "Yes" at Tweaks Page and check the Shairport-sync work fine.

2. Login to PiCorePlayer using ssh, default login: tc password: piCore

Install method:

$ `wget -O - https://raw.githubusercontent.com/sam0402/pCP-addon/main/AirPlay2/install_airplay2 | sh`

Airplay2 will be installed after auto reboot.

---

Airplay Classic install method:

$ `wget -O - https://raw.githubusercontent.com/sam0402/pCP-addon/main/AirPlay2/install_airplay_classic | sh` 

Ignore volume control

$ `wget -O - https://raw.githubusercontent.com/sam0402/pCP-addon/main/AirPlay2/install_airplay_classic_ignore_vol_ctl | sh`
