# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

URELEASE="wily"
inherit cmake-utils ubuntu-versionator

UURL="mirror://ubuntu/pool/universe/q/${PN}"
UVER_PREFIX="+${UVER_RELEASE}.${PVR_MICRO}"

DESCRIPTION="Qt platform abstraction (QPA) plugin for a Mir server (desktop)"
HOMEPAGE="https://launchpad.net/qtmir"
SRC_URI="${UURL}/${MY_P}${UVER_PREFIX}.orig.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror"

DEPEND="dev-libs/glib:2
	dev-qt/qtcore:5
	dev-qt/qtdeclarative:5
	dev-qt/qtgui:5[egl]
	dev-util/lttng-ust
	media-libs/fontconfig
	media-libs/mesa[egl,gles2]
	mir-base/mir:=
	sys-apps/ubuntu-app-launch"

S="${WORKDIR}/${PN}-${PV}${UVER_PREFIX}"
export QT_SELECT=5
