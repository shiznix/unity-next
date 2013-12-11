# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils ubuntu-versionator

UURL="mirror://ubuntu/pool/main/p/${PN}"
URELEASE="trusty"
UVER_PREFIX="+14.04.20131128.1"

DESCRIPTION="Implementation of the Platform API for a Mir server"
HOMEPAGE="https://launchpad.net/platform-api"
SRC_URI="${UURL}/${MY_P}${UVER_PREFIX}.orig.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror"

RDEPEND="dev-libs/boost:="
DEPEND="app-misc/location-service
	dev-libs/boost
	dev-libs/dbus-cpp
	mir-base/mir
	net-misc/url-dispatcher
	sys-apps/dbus"

S="${WORKDIR}/${PN}-${PV}${UVER_PREFIX}"

src_prepare() {
	# libubuntu_application_api.so will only be built if libhybris is installed #
	# Libhybris is for android devices only so why does 'platform-api' hardcode this requirement ?! #
	# Strip it for desktops #
	sed -e 's:-lubuntu_application_api::g' \
		-i data/ubuntu-platform-api.pc.in
}

src_configure() {
	local mycmakeargs="${mycmakeargs}
		-DENABLE_MIRSERVER_IMPLEMENTATION=ON
		-DENABLE_MIRCLIENT_IMPLEMENTATION=ON"
	cmake-utils_src_configure

	# Ubuntu's 'pkg-config --cflags ...' outputs 'Requires:' first, and 'Cflags:' last #
	# Gentoo's 'pkg-config --cflags ...' outputs 'Cflags:' first, and 'Requires:' last #
	#  Re-order to what the source expects #
	sed -e 's:\(.*\)=\(.*dbus-cpp-0;\)\(.*\):\1=\3;\2:g' \
		-e 's:;$::g' \
			-i "${BUILD_DIR}"/CMakeCache.txt 
}
