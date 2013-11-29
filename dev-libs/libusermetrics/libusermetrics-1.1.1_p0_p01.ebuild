# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils ubuntu-versionator

UURL="mirror://ubuntu/pool/universe/libu/${PN}"
URELEASE="saucy"
UVER_PREFIX="+13.10.20131003"

DESCRIPTION="Library for retrieving anonymous metrics about users"
HOMEPAGE="http://launchpad.net/libusermetrics"
SRC_URI="${UURL}/${MY_P}${UVER_PREFIX}.orig.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror"

DEPEND="dev-db/qdjango
	dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dev-qt/qtgui:5
	dev-qt/qtsql:5[sqlite]
	dev-qt/qtxmlpatterns:5
	sys-libs/libapparmor
	x11-libs/gsettings-qt
	x11-libs/libqtdbustest"

S="${WORKDIR}/${PN}-${PV}${UVER_PREFIX}"
