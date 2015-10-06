# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

URELEASE="wily"
inherit qt5-build gnome2-utils ubuntu-versionator

UURL="mirror://ubuntu/pool/universe/u/${PN}"
UVER_PREFIX=".trunk.phablet2+${UVER_RELEASE}.${PVR_MICRO}"

DESCRIPTION="Ubuntu on-screen keyboard data files"
HOMEPAGE="https://launchpad.net/ubuntu-keyboard"
SRC_URI="${UURL}/${MY_P}${UVER_PREFIX}.orig.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror"

DEPEND="app-i18n/libpinyin
	app-i18n/maliit-framework
	app-text/presage
	mir-base/platform-api
	x11-libs/ubuntu-ui-toolkit"

S="${WORKDIR}/${PN}-${PV}${UVER_SUFFIX}${UVER_PREFIX}"
QT5_BUILD_DIR="${S}"

src_prepare() {
	qt5-build_src_prepare
	export PATH="${QT5_BINDIR}:${PATH}"
}

pkg_preinst() {
	gnome2_schemas_savelist
}

pkg_postinst() {
	gnome2_schemas_update
}

pkg_postrm() {
	gnome2_schemas_update
}
