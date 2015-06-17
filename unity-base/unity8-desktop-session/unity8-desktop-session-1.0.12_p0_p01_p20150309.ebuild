# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

URELEASE="vivid"
inherit autotools eutils ubuntu-versionator

UURL="mirror://ubuntu/pool/universe/u/${PN}"
UVER_PREFIX="+${UVER_RELEASE}.${PVR_MICRO}"

DESCRIPTION="Unity8 desktop session"
HOMEPAGE="Unity8 desktop session"
SRC_URI="${UURL}/${MY_P}${UVER_PREFIX}.orig.tar.gz"

LICENSE="GPL-3 CC-BY-SA-3.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror"

DEPEND="mir-base/qtmir
	mir-base/unity-system-compositor
	net-misc/url-dispatcher
	sys-apps/ubuntu-app-launch
	unity-base/qtubuntu
	unity-base/unity8"

S="${WORKDIR}/${PN}-${PV}${UVER_PREFIX}"

src_prepare() {
	eautoreconf
}
