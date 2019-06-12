#!/bin/bash
BASEDIR="$(dirname $(realpath $0))"
WORKER=$(cat ${BASEDIR}/hil-worker.ips)

for w in $WORKER; do
  echo "Reboot HIL worker: $w"
  ssh pi@$w "sudo reboot" > /dev/null &
done
