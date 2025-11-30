#!/bin/sh
#
# Copyright (c) 2025 The FreeBSD Foundation
#
# This software was developed by Pierre Pronchery <pierre@defora.net> at Defora
# Networks GmbH under sponsorship from the FreeBSD Foundation.


BOMTOOL="bomtool"
DEBUG="_debug"
FIND="find"
MKDIR="mkdir -p"
RM="rm -f"

_debug() {
	echo "$@" 1>&2
	"$@"
}

$DEBUG $MKDIR spdx &&
	cd spdx &&
	$DEBUG $FIND ../pkgconfig -type f -a -name '*.pc' -print | while read filename; do
	pkgconfig=${filename#../pkgconfig/}
	pkgconfig=${pkgconfig%.pc}
	spdx="$pkgconfig.spdx"
	PKG_CONFIG_LIBDIR="$PWD/../pkgconfig" $DEBUG $BOMTOOL -- "$pkgconfig" > "$spdx" || $RM -- "$spdx"
done
