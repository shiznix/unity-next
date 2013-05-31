# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_DEPEND="2:2.7"

inherit qt5-build cmake-utils python bzr ubuntu-versionator	# Must inherit cmake-utils after qt5-build and bzr after cmake-utils

DESCRIPTION="Indicators QML client base library and specialized plugins (messaging, power, date, network)"
HOMEPAGE="https://launchpad.net/indicators-client"
SRC_URI=
EBZR_PROJECT="${PN}"
EBZR_BRANCH="trunk"
EBZR_REPO_URI="lp:${PN}"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="dev-libs/glib:2
	dev-qt/qtcore:5
	dev-qt/qtdeclarative:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtwidgets:5
	net-misc/networkmanager
	x11-libs/qmenumodel
	x11-libs/ubuntu-ui-toolkit"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	qt5-build_src_prepare
	export PATH="${QT5_BINDIR}:${PATH}"
}
