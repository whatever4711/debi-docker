FROM ubuntu:14.04 
MAINTAINER Marcel Grossmann <whatever4711@gmail.com>

RUN apt-get update && apt-get install -y --no-install-recommends\
    firefox \
    curl \
    unzip

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
        wine1.6 \
        winetricks \
    && rm -rf /var/lib/apt/lists/*

USER developer
ENV HOME /home/developer
ADD ./vpnmanager/vpnsmgr.exe /home/developer/ 
ADD ./vpnmanager/hamcore.se2 /home/developer/
CMD /usr/bin/firefox


