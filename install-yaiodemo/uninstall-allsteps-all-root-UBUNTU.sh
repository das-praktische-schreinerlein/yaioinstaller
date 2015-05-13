#!/bin/bash
###################
## uninstall yaio-demoapp
###################

export OS_SUFFIX=-UBUNTU
export COMMONOS_SUFFIX=-LINUX

export YAIOUSER=yaiodemo
export USER_SUFFIX=-yaiodemo
export BASE_DIR=$(dirname $0)
export SCRIPT_DIR=${BASE_DIR}

/etc/init.d/yaio-demoapp.sh stop
rm -fr /home/${YAIOUSER}
rm /etc/init.d/yaio-demoapp.sh
update-rc.d yaio-demoapp.sh remove
userdel ${YAIOUSER}

