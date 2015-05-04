# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python{2_7,3_3,3_4} )

URELEASE="vivid"
inherit qt5-build cmake-utils ubuntu-versionator

UURL="mirror://ubuntu/pool/universe/u/${PN}"
UVER_PREFIX="+${UVER_RELEASE}.${PVR_MICRO}"

DESCRIPTION="Unity 8 desktop shell"
HOMEPAGE="https://launchpad.net/unity8"
SRC_URI="${UURL}/${MY_P}${UVER_PREFIX}.orig.tar.gz"

LICENSE="GPL-3 LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror"

RDEPEND="unity-base/ubuntu-settings-components
	x11-libs/unity-notifications
	x11-misc/ubuntu-keyboard
	x11-themes/ubuntu-themes"
DEPEND="app-misc/pay-service
	dev-libs/glib:2
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
	net-misc/telephony-service
	sys-libs/libnih
	unity-base/connectivity-api
	unity-base/hud
	unity-base/ubuntu-system-settings
	unity-base/unity-api
	x11-libs/dee-qt
	x11-libs/gsettings-qt
	x11-libs/libxcb
	x11-libs/qmenumodel
	x11-libs/ubuntu-ui-toolkit"

S="${WORKDIR}/${PN}-${PV}${UVER_PREFIX}"
export PATH="/usr/$(get_libdir)/qt5/bin:${PATH}"

src_prepare() {
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
