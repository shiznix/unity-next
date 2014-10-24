# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

URELEASE="utopic"
inherit cmake-utils ubuntu-versionator

UURL="mirror://ubuntu/pool/main/d/${PN}"
UVER_PREFIX="+${UVER_RELEASE}.${PVR_MICRO}"

DESCRIPTION="Dbus-binding leveraging C++-11"
HOMEPAGE="http://launchpad.net/dbus-cpp"
SRC_URI="${UURL}/${MY_P}${UVER_PREFIX}.orig.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror"

RDEPEND="dev-libs/boost:="
DEPEND="dev-cpp/gtest
	dev-libs/boost
	dev-libs/process-cpp
	sys-apps/dbus"

S="${WORKDIR}/${PN}-${PV}${UVER_PREFIX}"
MAKEOPTS="-j1"

src_prepare() {
	# Disable '-Werror' #
	sed -e 's/-Werror//g' \
		-i CMakeLists.txt
}
