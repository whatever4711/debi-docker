#/bin/sh


# Replace 1000 with your user / group id
export uid=1001 gid=1001

mkdir -p /home/$USER_NAME
echo "$USER_NAME:x:${uid}:${gid}:$USER_NAME,,,:/home/$USER_NAME:/bin/bash" >> /etc/passwd 
echo "$USER_NAME:x:${uid}:" >> /etc/group 
echo "$USER_NAME ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/$USER_NAME 
chmod 0440 /etc/sudoers.d/$USER_NAME
chown ${uid}:${gid} -R /home/$USER_NAME

login $USER_NAME
export HOME=/home/$USER_NAME
export VPN=/home/$USER_NAME/vpn
cd $HOME 
wine msiexec /i $GECKO_SYSTEM 
mkdir $VPN 
cd $VPN 
wget $DOWNLOAD_SERVER/$SERVER 
unzip $SERVER 
rm $SERVER
#ADD ./vpnmanager/vpncmgr_x64.exe $VPN/ 
