# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

URELEASE="wily"
inherit cmake-utils ubuntu-versionator

UURL="mirror://ubuntu/pool/universe/u/${PN}"
UVER_PREFIX="+${UVER_RELEASE}.20150623.is.0.1.2+${UVER_RELEASE}.${PVR_MICRO}"

DESCRIPTION="Server and client library for desktop notifications in Unity"
HOMEPAGE="https://launchpad.net/qmenumodel"
SRC_URI="${UURL}/${MY_P}${UVER_PREFIX}.orig.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror"

DEPEND="dev-libs/glib:2
	dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dev-qt/qtdeclarative:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtwidgets:5"

S="${WORKDIR}/${PN}-${PV}${UVER_PREFIX}"
