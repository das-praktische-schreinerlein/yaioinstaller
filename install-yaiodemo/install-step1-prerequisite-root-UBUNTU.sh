#!/bin/bash
###################
## prepare system for yaio-install
###################
SCRIPT_DIR=$(dirname $0)/
OS_SUFFIX=-LINUX

# load utils
. ${SCRIPT_DIR}/utils${OS_SUFFIX}.sh

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
apt-get -y remove maven
apt-get -y install gdebi
wget http://ppa.launchpad.net/natecarlson/maven3/ubuntu/pool/main/m/maven3/maven3_3.2.1-0~ppa1_all.deb
gdebi --non-interactive maven3_3.2.1-0~ppa1_all.deb
ln -s /usr/share/maven3/bin/mvn /usr/bin/maven
ln -s /usr/share/maven3/bin/mvn /usr/bin/mvn

# install nodejs 10
apt-cache showpkg nodejs
apt-get remove node
apt-get install -q -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" nodejs=0.10.25~dfsg2-2ubuntu1
apt-get install -q -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" npm
# link because of collision with node-package
apt-get remove node
ln -s /usr/bin/nodejs /usr/sbin/node

# cleanup
apt-get autoremove -q -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold"

# install git
apt-cache showpkg git
apt-get install -q -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" git

# install graphviz for yaio-plantuml-service
apt-get install -q -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" graphviz

# install wkhtmltopdf for yaio-webshot-service
wget http://download.gna.org/wkhtmltopdf/0.12/0.12.2.1/wkhtmltox-0.12.2.1_linux-trusty-amd64.deb
sudo dpkg -i wkhtmltox-0.12.2.1_linux-trusty-amd64.deb
sudo apt-get -y -f install
sudo dpkg -i wkhtmltox-0.12.2.1_linux-trusty-amd64.deb

# install ghostscript for yaio-metaextract-service (tess4j)
apt-get install -q -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" ghostscript

# install chrome+xvfb for e2e-tests
apt-get install -q -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" chromium-browser
apt-get install -q -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" xvfb

# Make sure that Xvfb starts everytime the box/vm is booted:
echo "Starting X virtual framebuffer (Xvfb) in background..."
Xvfb -ac $XVFB_DISPLAY -screen 0 1280x1024x16 &