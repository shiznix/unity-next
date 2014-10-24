# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python{2_7,3_2,3_3} )

URELEASE="utopic"
inherit qt5-build cmake-utils ubuntu-versionator

UURL="mirror://ubuntu/pool/universe/u/${PN}"
#UVER_PREFIX="+${UVER_RELEASE}.20140918.3"
UVER_PREFIX="+14.10.20141013.2"

DESCRIPTION="Unity 8 desktop shell"
HOMEPAGE="https://launchpad.net/unity8"
SRC_URI="${UURL}/${MY_P}${UVER_PREFIX}.orig.tar.gz"

LICENSE="GPL-3 LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror"

RDEPEND="x11-themes/ubuntu-themes[phone]
	x11-libs/unity-notifications"
DEPEND="dev-libs/glib:2
	dev-libs/libhybris
	dev-libs/libsigc++:2
	dev-libs/libunity
	dev-libs/libupstart
	dev-libs/libusermetrics
	dev-perl/JSON
	dev-python/setuptools
	dev-qt/qt-mobility
	dev-qt/qtcore:5
	dev-qt/qtdeclarative:5[xml]
	dev-qt/qtxmlpatterns:5
	dev-util/android-headers
	dev-util/dbus-test-runner
	dev-util/pkgconfig
	media-fonts/ubuntu-font-family
	media-libs/mesa
	media-sound/pulseaudio
	sys-libs/libnih
	unity-base/hud
	unity-base/unity-api
	x11-libs/dee-qt
	x11-libs/gsettings-qt
	x11-libs/libxcb
	x11-libs/qmenumodel
	x11-libs/ubuntu-ui-toolkit"

S="${WORKDIR}/${PN}-${PV}${UVER_PREFIX}"
export PATH="/usr/$(get_libdir)/qt5/bin:${PATH}"

src_prepare() {
	sed -e 's:msg:MESSAGE:g' \
		-i cmake/modules/{Plugins,QmlTest}.cmake
	qt5-build_src_prepare
	cmake-utils_src_prepare
}

src_compile() {
	addpredict $XDG_RUNTIME_DIR/dconf
	cmake-utils_src_compile
}

src_install() {
	cmake-utils_src_install

	exeinto /usr/bin
	doexe "${FILESDIR}/unity8_run.sh"
}

pkg_postinst() {
	elog
	elog "To run Unity8, open an xterm on your desktop and run '/usr/bin/unity8_run.sh'"
	elog
}
