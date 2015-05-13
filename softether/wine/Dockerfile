FROM whatever4711/debi-tools:latest
MAINTAINER Marcel Grossmann <whatever4711@gmail.com>

RUN dpkg --add-architecture i386

RUN apt-get update && \
    apt-get install -y wine --no-install-recommends && \
    dpkg --add-architecture i386 && \
    apt-get update && \
    apt-get install -y wine32

RUN apt-get install -y xvfb

#RUN apt-get purge -y software-properties-common
RUN apt-get autoclean -y

ADD ./vpnmanager/vpnsmgr.exe /
