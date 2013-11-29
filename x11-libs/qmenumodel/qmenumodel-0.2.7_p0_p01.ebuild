# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit qt5-build cmake-utils ubuntu-versionator

UURL="mirror://ubuntu/pool/universe/q/${PN}"
URELEASE="saucy"
UVER_PREFIX="+13.10.20131016"

DESCRIPTION="GMenuModel Qt bindings"
HOMEPAGE="https://launchpad.net/qmenumodel"
SRC_URI="${UURL}/${MY_P}${UVER_PREFIX}.orig.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="mirror"

DEPEND="dev-libs/glib:2
	dev-qt/qtcore:5
	dev-qt/qtdeclarative:5
	dev-qt/qtdbus:5
	dev-qt/qtnetwork:5
	dev-qt/qttest:5
	dev-qt/qtwidgets:5
	test? ( dev-util/dbus-test-runner )"

S="${WORKDIR}/${PN}-${PV}${UVER_PREFIX}"

src_prepare() {
	qt5-build_src_prepare
	export PATH="${QT5_BINDIR}:${PATH}"
}
