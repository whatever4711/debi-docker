FROM debian:latest
MAINTAINER Marcel Grossmann <whatever4711@gmail.com>

RUN apt-get update
RUN apt-get -y install wget gcc make automake autoconf debhelper libssl-dev pkg-config python-all python-qt4 python-zopeinterface python-twisted-conch gdebi-core

RUN mkdir openvswitch
RUN cd openvswitch
 
RUN wget http://openvswitch.org/releases/openvswitch-1.10.0.tar.gz
 
RUN tar xvfz openvswitch-1.10.0.tar.gz
 
RUN mv openvswitch-1.10.0.tar.gz openvswitch_1.10.0.orig.tar.gz
 
RUN cd openvswitch-1.10.0
RUN dpkg-buildpackage -us -uc
RUN cd ..
RUN gdebi openvswitch-datapath-source_1.10.0-1_all.deb
RUN module-assistant auto-install openvswitch-datapath // Wait a few minutes for compilation to finish
RUN gdebi openvswitch-common_1.10.0-1_amd64.deb
RUN gdebi openvswitch-switch_1.10.0-1_amd64.deb

#RUN apt-get -y install net-tools iproute
#RUN apt-get -y install iputils-*
RUN apt-get clean && rm -rf /var/cache/apt/* /var/lib/apt/lists/*

