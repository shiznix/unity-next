# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit qt5-build cmake-utils bzr ubuntu-versionator	# bzr must inherit after cmake-utils

DESCRIPTION="GMenuModel Qt bindings"
HOMEPAGE="https://launchpad.net/qmenumodel"
SRC_URI=
EBZR_PROJECT="${PN}"
EBZR_BRANCH="trunk"
EBZR_REPO_URI="lp:${PN}"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS=""
IUSE="test"

DEPEND="dev-libs/glib:2
	dev-qt/qtcore:5
	dev-qt/qtdeclarative:5
	dev-qt/qtdbus:5
	dev-qt/qtnetwork:5
	dev-qt/qttest:5
	dev-qt/qtwidgets:5
	test? ( dev-util/dbus-test-runner )"

src_prepare() {
	qt5-build_src_prepare
	export PATH="${QT5_BINDIR}:${PATH}"
}
