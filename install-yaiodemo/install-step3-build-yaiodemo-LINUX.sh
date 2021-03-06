#!/bin/bash
###################
## Configure and package yaio
###################

OS_SUFFIX=-LINUX
USER_PRAEFIX=yaiodemo-
SCRIPT_DIR=$(dirname $0)/

BASE_DIR=/home/yaiodemo/your-all-in-one
CONFIG_DIR=${BASE_DIR}/config

# load utils
. ${SCRIPT_DIR}/utils${OS_SUFFIX}.sh

# Config anpassen

# config/application.properties
replaceConfigFileBySed ${CONFIG_DIR}/yaio-application.properties ${SCRIPT_DIR}/${USER_PRAEFIX}application.properties${OS_SUFFIX}.sed

# config/log4j.properties
replaceConfigFileBySed ${CONFIG_DIR}/log4j.properties ${SCRIPT_DIR}/${USER_PRAEFIX}log4j.properties${OS_SUFFIX}.sed
cp ${CONFIG_DIR}/log4j.properties ${BASE_DIR}/src/test/java/

# protractor.yaio.conf.js
replaceConfigFileBySed ${BASE_DIR}/yaio-app-e2e/protractor.yaio.conf.js ${SCRIPT_DIR}/${USER_PRAEFIX}protractor.yaio.conf.js${OS_SUFFIX}.sed

# sbin/yaio-demoapp.sh
replaceConfigFileBySed ${BASE_DIR}/sbin/yaio-demoapp.sh ${SCRIPT_DIR}/${USER_PRAEFIX}yaio-demoapp.sh${OS_SUFFIX}.sed

# letzte Leerzeilen löschen
# var/hsqldb/yaio.script
#replaceConfigFileBySed ${BASE_DIR}/var/hsqldb/yaio.script ${SCRIPT_DIR}/${USER_PRAEFIX}hsqldbyaio.script${OS_SUFFIX}.sed
sed -e :a -e '/^\n*$/{$d;N;};/\n$/ba' ${BASE_DIR}/var/hsqldb/yaio.script > ${BASE_DIR}/var/hsqldb/yaio.script-new
mv ${BASE_DIR}/var/hsqldb/yaio.script ${BASE_DIR}/var/hsqldb/yaio.script-dist
mv ${BASE_DIR}/var/hsqldb/yaio.script-new ${BASE_DIR}/var/hsqldb/yaio.script

# generate
cd ${BASE_DIR}
mvn install
