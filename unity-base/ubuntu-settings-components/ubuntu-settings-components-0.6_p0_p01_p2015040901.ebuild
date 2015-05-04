# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

URELEASE="vivid"
inherit cmake-utils ubuntu-versionator

UURL="mirror://ubuntu/pool/universe/u/${PN}"
UVER_PREFIX="+${UVER_RELEASE}.${PVR_MICRO}"

DESCRIPTION="Ubuntu Settings Components"
HOMEPAGE="https://launchpad.net/ubuntu-settings-components"
SRC_URI="${UURL}/${MY_P}${UVER_PREFIX}.orig.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror"

DEPEND="dev-qt/qtcore:5
	dev-qt/qtdeclarative:5
	dev-qt/qtgui:5
	dev-qt/qtquickcontrols:5
	x11-themes/ubuntu-themes
	x11-libs/ubuntu-ui-toolkit"

S="${WORKDIR}/${PN}-${PV}${UVER_PREFIX}"
export PATH="${PATH}:/usr/$(get_libdir)/qt5/bin"	# Need to see QT5's qmake
