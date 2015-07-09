#!/bin/bash
###################
## prepare system for yaio-install
###################

# set timezone
echo 'Europe/Berlin' | tee /etc/timezone > /dev/null
dpkg-reconfigure -f noninteractive tzdata

# deactivate services
service php5-fpm stop
service mysql stop
update-rc.d -f php5-fpm remove
update-rc.d -f mysql remove

# set noninteractive and updatepackages
export DEBIAN_FRONTEND=noninteractive
apt-get update -q

# install java1.7
apt-cache showpkg java
apt-get install -q -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" openjdk-7-jdk

# install maven
sudo apt-get -y remove maven
sudo apt-get -y remove maven3
sudo apt-get -y install gdebi
wget http://ppa.launchpad.net/natecarlson/maven3/ubuntu/pool/main/m/maven3/maven3_3.2.1-0~ppa1_all.deb
sudo gdebi --non-interactive maven3_3.2.1-0~ppa1_all.deb
sudo ln -s /usr/share/maven3/bin/mvn /usr/bin/maven
sudo ln -s /usr/share/maven3/bin/mvn /usr/bin/mvn

# install nodejs 10
apt-cache showpkg nodejs
apt-get remove node
apt-get install -q -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" nodejs=0.10.25~dfsg2-2ubuntu1
apt-get install -q -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" npm
# link because of collision with node-package
ls -l /usr/bin/nodejs /usr/sbin/node
ln -s /usr/bin/nodejs /usr/sbin/node

# install git
apt-cache showpkg git
apt-get install -q -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" git

# install chrome+xvfb for e2e-tests
apt-get install -q -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" chromium-browser
apt-get install -q -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" xvfb

# Make sure that Xvfb starts everytime the box/vm is booted:
echo "Starting X virtual framebuffer (Xvfb) in background..."
Xvfb -ac $XVFB_DISPLAY -screen 0 1280x1024x16 &
export DISPLAY=$XVFB_DISPLAY
