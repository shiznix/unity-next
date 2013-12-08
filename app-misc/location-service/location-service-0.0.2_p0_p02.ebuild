# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils ubuntu-versionator

UURL="mirror://ubuntu/pool/main/l/${PN}"
URELEASE="trusty"
UVER_PREFIX="+13.10.20131016.1"

DESCRIPTION="Location service aggregating position/velocity/heading"
HOMEPAGE="http://launchpad.net/location-service"
SRC_URI="${UURL}/${MY_P}${UVER_PREFIX}.orig.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror"

PDEPEND="mir-base/platform-api"
DEPEND="dev-cpp/gflags
	dev-cpp/glog
	sys-apps/dbus"

S="${WORKDIR}/${PN}-${PV}${UVER_PREFIX}"

src_configure() {
	cmake-utils_src_configure

	# Ubuntu's 'pkg-config --cflags ...' outputs Requires: first and Cflags: last #
	# Gentoo's 'pkg-config --cflags ...' outputs Cflags: first and Requires: last #
	#  Re-order to what the source expects #
	sed -e 's:\(.*\)=\(.*dbus-cpp-0;\)\(.*\):\1=\3;\2:g' \
		-e 's:;$::g' \
			-i "${BUILD_DIR}"/CMakeCache.txt
}
