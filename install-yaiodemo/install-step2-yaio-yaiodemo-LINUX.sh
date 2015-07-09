#!/bin/bash
###################
## download and prepare yaio
###################
SCRIPT_DIR=$(dirname $0)/
OS_SUFFIX=-LINUX
HOME_DIR=/home/yaiodemo

# load utils
. ${SCRIPT_DIR}/utils${OS_SUFFIX}.sh

# download
cd ${HOME_DIR}
git clone https://github.com/das-praktische-schreinerlein/your-all-in-one.git
cd your-all-in-one/

# Rechte
chmod 755 sbin -R
mkdir logs

# install all local
npm install
./node_modules/.bin/webdriver-manager update
./node_modules/.bin/webdriver-manager start > logs/webdriver-manager.log 2>&1 &
