# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

URELEASE="wily"
inherit cmake-utils ubuntu-versionator

UURL="mirror://ubuntu/pool/universe/c/${PN}"
UVER_PREFIX="+15.04.${PVR_MICRO}"

DESCRIPTION="Ubuntu Connectivity Qt API"
HOMEPAGE="https://launchpad.net/connectivity-api"
SRC_URI="${UURL}/${MY_P}${UVER_PREFIX}.orig.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror"

DEPEND="dev-qt/qtcore:5
	dev-qt/qtdbus:5"

S="${WORKDIR}/${PN}-${PV}${UVER_PREFIX}"
export QT_SELECT=5
