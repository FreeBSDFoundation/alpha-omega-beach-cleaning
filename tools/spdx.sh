#!/bin/sh
#
# Copyright (c) 2025 The FreeBSD Foundation
#
# This software was developed by Pierre Pronchery <pierre@defora.net> at Defora
# Networks GmbH under sponsorship from the FreeBSD Foundation.


BOMTOOL="bomtool"
FIND="find"
MKDIR="mkdir -p"
RM="rm -f"

$MKDIR spdx &&
	cd spdx &&
	$FIND ../pkgconfig -type f -a -name '*.pc' -print | while read filename; do
	pkgconfig=${filename#../pkgconfig/}
	pkgconfig=${pkgconfig%.pc}
	spdx="$pkgconfig.spdx"
	PKG_CONFIG_LIBDIR="$PWD/../pkgconfig" $BOMTOOL -- "$pkgconfig" > "$spdx" || $RM -- "$spdx"
done
