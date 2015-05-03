# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

URELEASE="vivid"
inherit cmake-utils multilib ubuntu-versionator

UURL="mirror://ubuntu/pool/universe/h/${PN}"
UVER_PREFIX="+${UVER_RELEASE}.${PVR_MICRO}"

DESCRIPTION="History service to store messages and calls for Ubuntu"
HOMEPAGE="https://launchpad.net/history-service"
SRC_URI="${UURL}/${MY_P}${UVER_PREFIX}.orig.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror"

DEPEND="dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dev-qt/qtpim:5
	dev-qt/qtsql:5
	media-libs/qt-gstreamer[qt5]
	>=net-libs/telepathy-qt-0.9.6[qt5]"

S="${WORKDIR}/${PN}-${PV}${UVER_PREFIX}"
export PATH="/usr/$(get_libdir)/qt5/bin:${PATH}"	# Need to see QT5's qmake
