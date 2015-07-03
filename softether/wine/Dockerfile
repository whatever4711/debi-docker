FROM ubuntu:latest 
MAINTAINER Marcel Grossmann <whatever4711@gmail.com>

USER root

# Define which versions we need
ENV WINE_PPA_VERSION 1.7
ENV WINE_MONO_VERSION 4.5.6
ENV WINE_GECKO_VERSION 2.36

RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    unzip \
    sudo 

RUN apt-get install -y --no-install-recommends \
    software-properties-common \
    && add-apt-repository -y ppa:ubuntu-wine/ppa

# Replace 1000 with your user / group id
RUN export uid=1000 gid=1000 && \
    mkdir -p /home/developer && \
    echo "developer:x:${uid}:${gid}:Developer,,,:/home/developer:/bin/bash" >> /etc/passwd && \
    echo "developer:x:${uid}:" >> /etc/group && \
    echo "developer ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/developer && \
    chmod 0440 /etc/sudoers.d/developer && \
    chown ${uid}:${gid} -R /home/developer

RUN dpkg --add-architecture i386 \
    && apt-get update -y \
    && apt-get install -y --no-install-recommends \
        wine$WINE_PPA_VERSION \
        wine-gecko$WINE_GECKO_VERSION \
	wine-mono$WINE_MONO_VERSION \
    && rm -rf /var/lib/apt/lists/*

# Use latest version of winetricks from github
RUN curl -SL 'http://winetricks.org/winetricks' -o /usr/local/bin/winetricks \
    && chmod +x /usr/local/bin/winetricks

USER developer
ENV HOME /home/developer
ADD ./vpnmanager/vpnsmgr.exe /home/developer/ 
ADD ./vpnmanager/hamcore.se2 /home/developer/
CMD /usr/bin/firefox


