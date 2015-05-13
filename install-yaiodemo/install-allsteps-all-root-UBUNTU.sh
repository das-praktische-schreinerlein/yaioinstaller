#!/bin/bash
###################
## install yaio-demoapp
###################

export OS_SUFFIX=-UBUNTU
export COMMONOS_SUFFIX=-LINUX

export YAIOUSER=yaiodemo
export USER_SUFFIX=-yaiodemo
export BASE_DIR=$(dirname $0)
export SCRIPT_DIR=${BASE_DIR}

chmod 755 ${SCRIPT_DIR}/*.sh

# create user
useradd -m ${YAIOUSER}

# install
${SCRIPT_DIR}/install-step1-prerequisite-root${OS_SUFFIX}.sh
su ${YAIOUSER} -c ${SCRIPT_DIR}/install-step2-yaio${USER_SUFFIX}${COMMONOS_SUFFIX}.sh
su ${YAIOUSER} -c ${SCRIPT_DIR}/install-step3-build${USER_SUFFIX}${COMMONOS_SUFFIX}.sh
su ${YAIOUSER} -c ${SCRIPT_DIR}/install-step4-apppropagator${USER_SUFFIX}${COMMONOS_SUFFIX}.sh
${SCRIPT_DIR}/install-step5-post-root${OS_SUFFIX}.sh


