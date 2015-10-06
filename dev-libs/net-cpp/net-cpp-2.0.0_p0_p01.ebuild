# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

URELEASE="wily"
inherit cmake-utils ubuntu-versionator

UURL="mirror://ubuntu/pool/universe/n/${PN}"

DESCRIPTION="C++11 library for networking processes"
HOMEPAGE="http://launchpad.net/net-cpp"
SRC_URI="${UURL}/${MY_P}.orig.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror"

DEPEND="dev-libs/boost:=
	dev-libs/jsoncpp
	dev-libs/process-cpp
	net-misc/curl"

S="${WORKDIR}/${PN}-${PV}${UVER_PREFIX}"
