#!/bin/sh

tag=v2.3 

mkdir -p /tmp
cd /tmp
echo "Cloning Openvswitch git repository to /tmp/ovs"

git clone --branch $tag https://github.com/openvswitch/ovs.git
cd ovs

echo "Building OVS"
DEB_BUILD_OPTIONS='parallel=8' fakeroot debian/rules binary > build.log
