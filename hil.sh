#!/bin/bash
BASEDIR="$(dirname $(realpath $0))"
ARTIFACTS="https://ci.riot-os.org/hil/job/RIOT-HIL/job/nightly/lastBuild/artifact/*zip*/archive.zip"
OUTDIR=$1
[ -z "$OUTDIR" ] && {
  echo "USAGE: $0 <output folder>"
  exit 2
}
[ ! -d $OUTDIR ] && {
  echo "Output folder ($OUTDIR), does not exists!"
  exit 3
}
# download artifacts from latest nightly hil build by jenkins
wget -P ${OUTDIR} ${ARTIFACTS}
unzip -d ${OUTDIR} ${OUTDIR}/archive.zip
mv ${OUTDIR}/archive/build/robot ${OUTDIR}/robot
rm -rf ${OUTDIR}/archive ${OUTDIR}/archive.zip
# generate robot and xml output
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
