#!/bin/bash
BASE_REPO=https://github.com/RIOT-OS/RIOT
BASE_DIR=/tmp/RIOT.hil
HIL_REPO=https://github.com/smlng/RIOT
HIL_BRANCH=pr/robot/i2c
COMMIT=$1
[ -z "$COMMIT" ] && {
    COMMIT=master
}
echo "COMMIT/BRANCH=${COMMIT}"

git config --global user.email "$(hostname)@ci.riot-os.org"
git config --global user.name "$(hostname)"
rm -rf ${BASE_DIR}
[ ! -d ${BASE_DIR} ] && {
    git clone ${BASE_REPO} ${BASE_DIR}
}
cd ${BASE_DIR}
git fetch --all
git checkout -f ${COMMIT}
git pull -f
git pull -f --no-commit ${HIL_REPO} ${HIL_BRANCH}
BUILD_DIR=${BASE_DIR}/build/${COMMIT} PHILIP_PORT=/dev/ttyAMA0 make -C tests/periph_i2c/ flash robot-test
