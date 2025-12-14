#!/bin/sh
#
# Copyright (c) 2025 The FreeBSD Foundation
#
# This software was developed by Pierre Pronchery <pierre@defora.net> at Defora
# Networks GmbH under sponsorship from the FreeBSD Foundation.


#variables
BOMTOOL="bomtool"
DEBUG="_debug"
FIND="find"
MKDIR="mkdir -p"
PROGNAME="spdx.sh"
RM="rm -f"

#functions
#debug
_debug() {
	echo "$@" 1>&2
	"$@"
}

_spdx() {
	target="$1"

	$DEBUG $MKDIR -- "$target"				|| return 2
	cd "$target" &&
		$DEBUG $FIND ../pkgconfig -type f -a -name '*.pc' -print | while read filename; do
			pkgconfig=${filename#../pkgconfig/}
			pkgconfig=${pkgconfig%.pc}
			spdx="$pkgconfig.spdx"
			PKG_CONFIG_LIBDIR="$PWD/../pkgconfig" $DEBUG $BOMTOOL -- "$pkgconfig" > "$spdx"
			if [ $? -ne 0 ]; then
				$RM -- "$spdx"
				ret=2
			fi
		done
	return $ret
}

#usage
_usage()
{
	echo "Usage: $PROGNAME [-c][-P prefix] target..." 1>&2
	return 1
}

#main
ret=0
clean=0
while getopts "cO:P:" name; do
	case $name in
		c)
			clean=1
			;;
		O)
			export "${OPTARG%%=*}"="${OPTARG#*=}"
			;;
		P)
			#XXX ignore for compatibility
			;;
		?)
			_usage
			exit $?
			;;
	esac
done
shift $(($OPTIND - 1))
if [ $# -ne 1 ]; then
	_usage
	exit $?
fi

#clean
if [ $clean -ne 0 ]; then
	exit 0
fi

#spdx
for target in "$@"; do
	_spdx "$target"
done
exit $?
