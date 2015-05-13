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
apt-cache showpkg maven
apt-get install -q -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" maven=3.0.5-1

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
