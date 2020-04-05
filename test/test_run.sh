#!/bin/sh

[ "$2" == "" ] && {
	echo "use: $0 PROGRAM DIR [TEST ..]" >&2
	exit 1
}

PROGR="$1"
[ -x "${PROGR}" ] || {
	echo "${PROGR} not exist" >&2
	exit 1
}

CONFDIR="$2"
[ -d "${CONFDIR}" ] || {
	echo "${CONFDIR} not exist" >&2
	exit 1
}


run_test() {
	[ "$1" == "" ] && return 1
	DIR=$( dirname ${1} )
	NAME=$( basename ${1} )
	local TEST=${NAME%.*}
	TEMPDIR=$( mktemp -d /tmp/test-${TEST}.XXXXXXXX )
	echo -n "${TEST} "
	ARGS=$( cat ${1} )
	ECODE=$( cat ${DIR}/${TEST}.ret 2>/dev/null ) || ECODE="0"
	INF="${DIR}/${TEST}.in.txt"
	OUTF="${DIR}/${TEST}.out.txt"
	outfile="${TEMPDIR}/${TEST}.out.txt"
	ERRF="${DIR}/${TEST}.err.txt"
	errfile="${TEMPDIR}/${TEST}.err.txt"
	if [ -e "${INF}" ]; then
		${PROGR} < ${INF} > ${outfile} 2>${errfile}
	else
		${PROGR} > ${outfile} 2>${errfile}
	fi
	ret="$?"
	ostatus="0"
	estatus="1"
	if [ -e "${OUTF}" ]; then
		diff -u ${OUTF} ${outfile} > ${outfile}.diff
		ostatus="${?}"
	fi
	if [ -e "${ERRF}" ]; then
		diff -u ${ERRF} ${errfile} > ${errfile}.diff
		estatus="${?}"
	fi
	if [ "$ret" == "${ECODE}" -a "${ostatus}" == "0" -a "${estatus}" == "0" ]; then
		echo PASS
		status="0"
	else
		echo FAIL
		status="1"
	fi
	[ "$ret" != "${ECODE}" ] && echo "exited with $? (want ${ECODE})"
	if [ "${ostatus}" != "0" ]; then
		echo "stdout:"
		cat ${outfile}.diff
	fi
	if [ "${estatus}" != "0" ]; then
		echo "stderr:"
		cat ${errfile}.diff
	fi

	[ "${NOCLEANUP}" == "1" ] || rm -rf "${TEMPDIR}"
	return ${status}
}

run=0
fail=0
skipped=0

if [ "$3" == "" ]; then
	for t in ${CONFDIR}/*.test ; do
		run=$( expr ${run} + 1 )
		run_test ${t}
	done
else
	while [ -n "${3}" ]; do
		t="${CONFDIR}/${3}.test"
		if [ -e "${t}" ]; then
			run=$( expr ${run} + 1 )
			if ! run_test ${t} ; then
				failed=$( expr ${failed} + 1 )
			fi
		else
			echo "${t} SKIP"
			skipped=$( expr ${skipped} + 1 )
		fi
		shift
	done
fi

echo "run ${run} tests, ${skipped} skipped, ${fail} failed"
exit ${failed}
