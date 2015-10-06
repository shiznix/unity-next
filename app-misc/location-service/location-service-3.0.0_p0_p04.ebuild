# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

URELEASE="wily"
inherit cmake-utils ubuntu-versionator

UURL="mirror://ubuntu/pool/universe/l/${PN}"

DESCRIPTION="Location service aggregating position/velocity/heading"
HOMEPAGE="http://launchpad.net/location-service"
SRC_URI="${UURL}/${MY_P}.orig.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror"

DEPEND="dev-cpp/gflags
	dev-cpp/glog
	dev-libs/boost:=
	dev-libs/dbus-cpp
	dev-libs/json-c
	dev-libs/net-cpp
	dev-libs/process-cpp
	dev-libs/properties-cpp
	dev-libs/trust-store
	sys-apps/dbus"

S="${WORKDIR}/${PN}-${PV}${UVER_PREFIX}"

src_configure() {
	# GPS is for the Android platform, so disable it #
	mycmakeargs="${mycmakeargs}
		-DLOCATION_SERVICE_ENABLE_GPS_PROVIDER=FALSE"
	cmake-utils_src_configure

	# Ubuntu's 'pkg-config --cflags ...' outputs Requires: first and Cflags: last #
	# Gentoo's 'pkg-config --cflags ...' outputs Cflags: first and Requires: last #
	#  Re-order to what the source expects #
	sed -e 's:\(.*\)=\(.*dbus-cpp-0;\)\(.*\):\1=\3;\2:g' \
		-e 's:;$::g' \
			-i "${BUILD_DIR}"/CMakeCache.txt
}
