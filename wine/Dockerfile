FROM ubuntu:latest 
MAINTAINER Marcel Grossmann <whatever4711@gmail.com>

USER root

# Define which versions we need
ENV WINE_PPA_VERSION 1.7
ENV WINE_MONO_VERSION 4.5.6
ENV WINE_GECKO_VERSION 2.36
ENV DOWNLOAD_SERVER http://www.softether-download.com/files/softether/v4.19-9599-beta-2015.10.19-tree/Windows/Admin_Tools/VPN_Server_Manager_and_Command-line_Utility_Package
ENV SERVER softether-vpn_admin_tools-v4.19-9599-beta-2015.10.19-win32.zip
ENV CLIENT xxx

RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    wget \
    unzip \
    sudo 

RUN apt-get install -y --no-install-recommends \
    software-properties-common \
    apt-transport-https \
    && add-apt-repository -y ppa:ubuntu-wine/ppa
#RUN wget -qO - https://dl.winehq.org/wine-builds/Release.key | apt-key add -
#RUN echo "deb https://dl.winehq.org/wine-builds/debian/ jessie main" > /etc/apt/sources.list.d/wine.list

# X-Server
RUN apt-get install -y --no-install-recommends \
    xauth   

RUN dpkg --add-architecture i386 \
    && apt-get update -y \
    && apt-get install -y --no-install-recommends \
#    wine32
        wine$WINE_PPA_VERSION \
        wine-gecko$WINE_GECKO_VERSION \
	wine-mono$WINE_MONO_VERSION 

ENV GECKO_SYSTEM /usr/share/wine/gecko/wine_gecko-$WINE_GECKO_VERSION-x86_64.msi 

# Use latest version of winetricks from github
RUN curl -SL 'http://winetricks.org/winetricks' -o /usr/local/bin/winetricks \
    && chmod +x /usr/local/bin/winetricks

# Clean up
RUN apt-get remove -y --purge software-properties-common \
    curl \
    && rm -rf /var/lib/apt/lists*

ENV USER_NAME ktr

# Replace 1000 with your user / group id
RUN export uid=1001 gid=1001 && \
    mkdir -p /home/$USER_NAME && \
    echo "$USER_NAME:x:${uid}:${gid}:$USER_NAME,,,:/home/$USER_NAME:/bin/bash" >> /etc/passwd && \
    echo "$USER_NAME:x:${uid}:" >> /etc/group && \
    echo "$USER_NAME ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/$USER_NAME && \
    chmod 0440 /etc/sudoers.d/$USER_NAME && \
    chown ${uid}:${gid} -R /home/$USER_NAME

USER $USER_NAME
ENV HOME /home/$USER_NAME
ENV VPN /home/$USER_NAME/vpn
RUN cd $HOME && wine msiexec /i $GECKO_SYSTEM && mkdir $VPN 
RUN cd $VPN && wget $DOWNLOAD_SERVER/$SERVER && unzip $SERVER && rm $SERVER
ADD ./vpnmanager/vpncmgr_x64.exe $VPN/ 
#ADD ./vpnmanager $HOME/ 
CMD ["wine32", "$VPN/vpnsmgr.exe"]

