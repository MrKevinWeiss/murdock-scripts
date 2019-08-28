#!/bin/bash
BASE_REPO=https://github.com/RIOT-OS/RobotFW-tests
BASE_DIR=/tmp/RIOT.hil
COMMIT=$1
[ -z "$COMMIT" ] && {
    COMMIT=master
}
echo "COMMIT/BRANCH=${COMMIT}"

git config --global user.email "$(hostname)@ci.riot-os.org"
git config --global user.name "$(hostname)"
rm -rf ${BASE_DIR}
git clone --recursive ${BASE_REPO} ${BASE_DIR}
cd ${BASE_DIR}/RIOT
git checkout -f ${COMMIT}
cd ${BASE_DIR}
BUILD_DIR=${BASE_DIR}/build/${COMMIT} PHILIP_PORT=/dev/ttyAMA0 make -C tests/periph_i2c/ flash robot-test
BUILD_DIR=${BASE_DIR}/build/${COMMIT} PHILIP_PORT=/dev/ttyAMA0 make -C tests/periph_uart/ flash robot-test
BUILD_DIR=${BASE_DIR}/build/${COMMIT} PHILIP_PORT=/dev/ttyAMA0 make -C tests/xtimer_cli/ flash robot-test
