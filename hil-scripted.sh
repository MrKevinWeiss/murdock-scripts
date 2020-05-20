#!/bin/bash
BASEDIR="$(dirname $(realpath $0))"
COMMIT=$1
OUTDIR=$2
[ -z "$COMMIT" ] && {
  echo "USAGE: $0 <branch|commit> <output folder>"
  exit 1
}
[ -z "$OUTDIR" ] && {
  echo "USAGE: $0 <branch|commit> <output folder>"
  exit 2
}
[ ! -d $OUTDIR ] && {
  echo "Output folder ($OUTDIR), does not exists!"
  exit 3
}
[ -z "$3" ] && {
WORKER=$(cat ${BASEDIR}/hil-worker.ips)
for w in $WORKER; do
  echo "Run HIL tests on worker: $w"
  ssh pi@$w "bash -s" < ${BASEDIR}/hil-test.sh "${COMMIT}" > /dev/null &
done
sleep 150
wait
for w in $WORKER; do
  echo "Get HIL results from worker: $w"
  rsync -avz pi@${w}:/tmp/RIOT.hil/build/${COMMIT}/robot ${OUTDIR}/
done
sleep 2
}
RFILES=$(find ${OUTDIR}/robot -name output.xml -exec echo {} +)
RPRINT=$(python3 -m robot.rebot -d ${OUTDIR}/robot \
		--name "RIOT HIL" \
		--suitestatlevel 2 \
		--tagstatinclude "BOARD*" \
		${RFILES})
RERROR=$?
[ "${RERROR}" != "0" ] && {
  echo "Some robot tests failed!"
  echo "${RERROR}" > ${OUTDIR}/robot/robot.fail
}
${BASEDIR}/hil-xml.sh ${OUTDIR}/robot
