#!/bin/bash
###################
## download and compile apppropagator
###################

HOME_DIR=/home/yaiodemo

cd ${HOME_DIR}
git clone https://github.com/das-praktische-schreinerlein/apppropagator.git
cd apppropagator/

# generate
cd ${BASE_DIR}
mvn package

cp target/apppropagator.jar ../your-all-in-one/sbin/apppropagator.jar