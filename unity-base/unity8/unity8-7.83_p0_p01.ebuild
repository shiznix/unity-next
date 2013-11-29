# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python{2_7,3_2,3_3} )

inherit qt5-build cmake-utils ubuntu-versionator

UURL="mirror://ubuntu/pool/universe/u/${PN}"
URELEASE="saucy"
UVER_PREFIX="+13.10.20131016.2"

DESCRIPTION="Unity 8 desktop shell"
HOMEPAGE="https://launchpad.net/unity8"
SRC_URI="${UURL}/${MY_P}${UVER_PREFIX}.orig.tar.gz"

LICENSE="GPL-3 LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror"

DEPEND="dev-libs/glib:2
	dev-libs/libsigc++:2
	dev-libs/libunity
	dev-libs/libupstart
	dev-libs/libusermetrics
	dev-perl/JSON
	dev-python/setuptools
	dev-qt/qtcore:5
	dev-qt/qtdeclarative:5[xml]
	dev-qt/qtjsbackend:5
	dev-qt/qtxmlpatterns:5
	dev-util/dbus-test-runner
	dev-util/pkgconfig
	media-fonts/ubuntu-font-family
	media-libs/mesa
	media-sound/pulseaudio
	mir-base/unity-mir
	sys-libs/libnih
	unity-base/hud
	unity-base/unity-api
	x11-libs/dee-qt
	x11-libs/gsettings-qt
	x11-libs/libxcb
	x11-libs/qmenumodel
	x11-libs/ubuntu-ui-toolkit"

S="${WORKDIR}/${PN}-${PV}${UVER_PREFIX}"
export PATH="${PATH}:/usr/$(get_libdir)/qt5/bin"

src_prepare() {
	# Workaround QT-5.2.0_beta1 cmake files for private headers #
	epatch -p1 "${FILESDIR}/qtgui_private-headers_fix.diff"

	sed -e 's:msg:MESSAGE:g' \
		-i cmake/modules/{Plugins,QmlTest}.cmake
	qt5-build_src_prepare
	cmake-utils_src_prepare	
}
