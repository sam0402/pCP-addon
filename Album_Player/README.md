# Album Player and Renderer for piCorePlayer

Script to install Album Player and Renderer on PiCorePlayer OS

Install method 1,

Paste the command line in the "User command #3" of Tweaks Page 

for pCP6

`wget -O - https://raw.githubusercontent.com/sam0402/pCP-addon/main/Album_Player/install_aprenderer.sh | sudo sh`

for pCP8

`wget -O - https://raw.githubusercontent.com/sam0402/pCP-addon/main/Album_Player/install_aprenderer_arm64.sh | sudo sh`

"Save" and "Reboot"

Album Player and Renderer will be installed after auto reboot twice.

Install method 2,

Login to PiCorePlayer using ssh, default login: `tc` password: `piCore`

run:

for pCP6

$ `wget -O - https://raw.githubusercontent.com/sam0402/pCP-addon/main/Album_Player/install_aprenderer.sh | sudo sh`

for pCP8

`wget -O - https://raw.githubusercontent.com/sam0402/pCP-addon/main/Album_Player/install_aprenderer_arm64.sh | sudo sh`

Album Player and Renderer will be installed after auto reboot.

Enjoy it!

port :7778 is for Album Player

port :7779 is for Renderer


