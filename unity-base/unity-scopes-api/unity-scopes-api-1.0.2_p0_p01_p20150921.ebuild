# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

URELEASE="wily"
inherit autotools cmake-utils ubuntu-versionator

UURL="mirror://ubuntu/pool/universe/u/${PN}"
UVER_PREFIX="+${UVER_RELEASE}.${PVR_MICRO}"

DESCRIPTION="API for Unity scopes integration"
HOMEPAGE="https://launchpad.net/unity-scopes-api"
SRC_URI="${UURL}/${MY_P}${UVER_PREFIX}.orig.tar.gz
	${UURL}/${MY_P}${UVER_PREFIX}-${UVER}.diff.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror"

DEPEND="dev-cpp/capnproto
	dev-cpp/gmock
	dev-libs/boost:=
	dev-libs/glib:2
	dev-libs/jsoncpp
	dev-libs/libaccounts-glib
	dev-libs/libsignon-glib
	dev-libs/net-cpp
	dev-libs/process-cpp
	dev-util/valgrind
	net-libs/zeromq3
	net-libs/zmqpp
	unity-base/unity-api"

S="${WORKDIR}/${PN}-${PV}${UVER_PREFIX}"
export CMAKE_BUILD_TYPE=none

src_prepare() {
	epatch -p1 "${WORKDIR}/${MY_P}${UVER_PREFIX}-${UVER}.diff"	# This needs to be applied for the debian/ directory to be present #

	# Don't build tests as they fail to compile #
	sed -i '/add_subdirectory(test)/d' "${S}/CMakeLists.txt" || die
}

src_install() {
	cmake-utils_src_install

	# Delete some files that are only useful on Ubuntu
	rm -rf "${ED}"etc/apport "${ED}"usr/share/apport
}
