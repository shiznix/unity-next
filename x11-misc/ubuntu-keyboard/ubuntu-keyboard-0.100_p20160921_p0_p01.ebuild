# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

URELEASE="yakkety"
inherit qt5-build gnome2-utils ubuntu-versionator

UURL="mirror://ubuntu/pool/main/u/${PN}"
UVER_PREFIX="+${UVER_RELEASE}.${PVR_MICRO}"

DESCRIPTION="Ubuntu on-screen keyboard data files"
HOMEPAGE="https://launchpad.net/ubuntu-keyboard"
SRC_URI="${UURL}/${MY_P}${UVER_PREFIX}.orig.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror"

DEPEND="app-i18n/anthy
	app-i18n/libpinyin
	app-i18n/maliit-framework
	app-text/presage
	dev-libs/libchewing
	dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dev-qt/qtdeclarative:5
	dev-qt/qtgui:5
	mir-base/mir:=
	mir-base/platform-api
	x11-libs/ubuntu-ui-toolkit"

S="${WORKDIR}"
QT5_BUILD_DIR="${S}"
export QT_SELECT=5

src_prepare() {
	ubuntu-versionator_src_prepare
	qt5-build_src_prepare
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
