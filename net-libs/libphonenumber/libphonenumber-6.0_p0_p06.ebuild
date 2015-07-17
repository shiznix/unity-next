# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

URELEASE="vivid"
inherit base cmake-utils ubuntu-versionator

UURL="mirror://ubuntu/pool/universe/libp/${PN}"
UVER_PREFIX="+r655"

DESCRIPTION="Google's phone number handling library"
HOMEPAGE="http://code.google.com/p/libphonenumber/"
SRC_URI="${UURL}/${MY_P}${UVER_PREFIX}.orig.tar.gz
	${UURL}/${MY_P}${UVER_PREFIX}-${UVER}.debian.tar.xz"

LICENSE="GPL-3 LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror"

DEPEND="dev-libs/boost:=
	dev-libs/icu:=
	dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dev-qt/qtnetwork:5
	dev-qt/qtxml:5
	net-libs/liboauth
	unity-base/signon[qt5]
	x11-libs/libaccounts-qt[qt5]"

S="${WORKDIR}/${PN}-${PV}${UVER_PREFIX}/cpp"
MAKEOPTS="${MAKEOPTS} -j1"

src_prepare() {
	# Ubuntu patchset #
	for patch in $(cat "${WORKDIR}/debian/patches/series" | grep -v \# ); do
		PATCHES+=( "${WORKDIR}/debian/patches/${patch}" )
	done
	base_src_prepare

	# Disable '-Werror' #
	sed -e 's/-Werror//g' \
		-i CMakeLists.txt
}
