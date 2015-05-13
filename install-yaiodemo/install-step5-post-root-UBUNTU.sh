#!/bin/bash
###############################
## install yaio-demoapp on runlevel
###############################
BASE_DIR=/home/yaiodemo/your-all-in-one

# sbin/yaio-demoapp.sh
cp ${BASE_DIR}/sbin/yaio-demoapp.sh /etc/init.d/
chown root /etc/init.d/yaio-demoapp.sh
chmod 500 /etc/init.d/yaio-demoapp.sh

cd /etc/init.d
update-rc.d yaio-demoapp.sh defaults

