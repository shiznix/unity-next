# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

URELEASE="yakkety"
inherit qt5-build ubuntu-versionator

UURL="mirror://ubuntu/pool/main/libq/${PN}"
UVER_PREFIX="+${UVER_RELEASE}.${PVR_MICRO}"

DESCRIPTION="QT library for accessing the ofono daemon, and a declarative plugin for Ofono"
HOMEPAGE="https://github.com/nemomobile/libqofono"
SRC_URI="${UURL}/${MY_P}${UVER_PREFIX}.orig.tar.gz
	${UURL}/${MY_P}${UVER_PREFIX}-${UVER}.debian.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="mirror"

DEPEND="dev-qt/qtcore:5
	dev-qt/qtdeclarative:5
	dev-qt/qtdbus:5
	dev-qt/qtxmlpatterns:5
	net-misc/ofono"

S="${WORKDIR}"
export QT_SELECT=5

src_prepare() {
	ubuntu-versionator_src_prepare
	use test || \
		sed -e 's:test$::g' \
			-i libqofono.pro || die
	qt5-build_src_prepare
}
