FROM debian:latest
MAINTAINER Marcel Grossmann <whatever4711@gmail.com>

RUN apt-get update
RUN apt-get -y install wget build-essential fakeroot
RUN apt-get -y install git
RUN apt-get -y install debhelper autoconf automake libssl-dev graphviz python-all python-qt4 python-zopeinterface python-twisted-conch libtool

RUN git clone https://github.com/openvswitch/ovs.git
RUN cd ovs
#8cores ;)
RUN DEB_BUILD_OPTIONS='parallel=8' fakeroot debian/rules binary

