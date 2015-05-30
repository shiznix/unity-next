# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

URELEASE="vivid"
inherit eutils autotools-multilib ubuntu-versionator

UURL="mirror://ubuntu/pool/universe/c/${PN}"

DESCRIPTION="RPC/Serialization system with capabilities support"
HOMEPAGE="http://capnproto.org"
SRC_URI="${UURL}/${MY_P}.orig.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
RESTRICT="mirror"

S="${WORKDIR}/${PN}-c++-${PV}"

src_prepare() {
	sed -e '/ldconfig/d' \
		-i Makefile.am
	eautoreconf
}
