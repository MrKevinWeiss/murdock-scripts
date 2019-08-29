#!/bin/sh -e

REPO=https://github.com/RIOT-OS/RIOT
BRANCHES="master"
HTTPROOT="/srv/http/ci.riot-labs.de-devel/devel"

BASEDIR="$(dirname $(realpath $0))"

. "${BASEDIR}/common.sh"

[ -f "${BASEDIR}/local.sh" ] && . "${BASEDIR}/local.sh"

REPO_DIR="${HTTPROOT}/$(repo_path ${REPO})"

main() {
    export NIGHTLY=1 STATIC_TESTS=0 SAVE_JOB_RESULTS=1

    echo -n "--- flushing redis test result cache: "
    redis-cli flushall

    for branch in $BRANCHES; do
        local commit="$(gethead $REPO $branch)"
        local output_dir_commit="${REPO_DIR}/$branch/${commit}"
        local output_dir="${output_dir_commit}.$(date +'%Y%m%d%H%M')"
        local latest_link="$(dirname "$output_dir")/latest"
        local last_commit=$(basename $(readlink -f "${latest_link}" | \
                            awk -F. '{print $1}'))

        build_commit "$REPO" "$branch" "$commit" "$output_dir" || continue

        ln -s -f -T "$output_dir" "$latest_link" || true
        ln -s -f -T "$output_dir" "$output_dir_commit" || true

	${BASEDIR}/hil.sh ${commit} ${output_dir}
 
	# generate JSON so it can be fetched by the web frontend
        ${BASEDIR}/update_nightly_list.py ${REPO_DIR} ${branch}
        ${BASEDIR}/notify.py ${REPO_DIR} ${commit} ${last_commit}
    done
}

main
