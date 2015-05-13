#!/bin/bash
###################
## download and prepare yaio
###################
HOME_DIR=/home/yaiodemo

cd ${HOME_DIR}
git clone https://github.com/das-praktische-schreinerlein/your-all-in-one.git
cd your-all-in-one/

# Rechte
chmod 755 sbin -R
mkdir logs

# install karma local
npm install karma --save-dev
npm install karma-phantomjs-launcher karma-jasmine karma-qunit karma-chrome-launcher karma-firefox-launcher plugin --save-dev

