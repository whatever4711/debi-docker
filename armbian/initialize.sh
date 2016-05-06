#!/bin/bash

DIR=/armbian

gpg --ignore-time-conflict --no-options --no-default-keyring --homedir /tmp/tmp.JrQS7d54Sa --no-auto-check-trustdb --trust-model always --keyring /etc/apt/trusted.gpg --primary-keyring /etc/apt/trusted.gpg --keyserver http://keys.gnupg.net --recv-keys E083A3782A194991
echo "deb http://repo.aptly.info/ squeeze main" > /etc/apt/sources.list.d/aptly.list
apt-get update && apt-get install -y --force-yes git aptly

mkdir $DIR
cd $DIR && git clone https://github.com/igorpecovnik/lib.git --depth 1

cp $DIR/lib/compile.sh $DIR/.
chmod +x $DIR/compile.sh

cat << EOF > lamobo.sh
#!/bin/bash
sudo ./compile.sh KERNEL_ONLY=no KERNEL_CONFIGURE=no BUILD_DESKTOP=no EXTERNAL=yes FORCE_CHECKOUT=yes BOARD=lamobo-r1 PROGRESS_DISPLAY=plain RELEASE=jessie BRANCH=next
EOF

chmod +x lamobo.sh

./compile.sh BRANCH=next BOARD=lamobo-r1 KERNEL_ONLY=yes KERNEL_CONFIGURE=no BUILD_DESKTOP=no PROGRESS_DISPLAY=plain RELEASE=jessie

