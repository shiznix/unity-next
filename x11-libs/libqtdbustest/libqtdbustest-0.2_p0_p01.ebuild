# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils ubuntu-versionator

UURL="mirror://ubuntu/pool/universe/libq/${PN}"
URELEASE="trusty"
UVER_PREFIX="+14.04.20131128.1"

DESCRIPTION="Library for testing DBus interactions using Qt"
HOMEPAGE="https://launchpad.net/libqtdbustest"
SRC_URI="${UURL}/${MY_P}${UVER_PREFIX}.orig.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror"

DEPEND="sys-apps/dbus
	dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dev-qt/qttest:5"

S="${WORKDIR}/${PN}-${PV}${UVER_PREFIX}"
