# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

GTESTVER="1.6.0"

inherit qt5-build cmake-utils bzr ubuntu-versionator	# bzr must inherit after cmake-utils

DESCRIPTION="Unity phablet series"
HOMEPAGE="https://launchpad.net/unity/phablet"
SRC_URI="http://googletest.googlecode.com/files/gtest-${GTESTVER}.zip"  # SRC_URI must be set before EBZR_REPO_URI
EBZR_PROJECT="phablet"
EBZR_BRANCH="trunk"
EBZR_REPO_URI="lp:unity/phablet"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="doc test"

RDEPEND="x11-libs/qmenumodel
	unity-indicators/indicators-client
	unity-lenses/unity-lens-mock
	unity-lenses/unity-lens-people-preview"
DEPEND="${RDEPEND}
	dev-cpp/gtest
	dev-libs/boost
	dev-libs/dee
	dev-libs/glib:2
	=dev-libs/libunity-preview-9999
	dev-qt/qtcore:5
	dev-qt/qtdeclarative:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qttest:5
	media-sound/pulseaudio
	sys-devel/gettext
	=unity-base/hud-preview-9999
	=unity-base/unity-preview-9999
	x11-libs/dee-qt[qt5]
	x11-libs/libxcb
	x11-themes/ubuntu-themes[phone]
	doc? ( app-doc/doxygen
		media-gfx/graphviz )"

src_unpack() {
	unpack ${A}
	bzr_src_unpack
}

src_prepare() {
	epatch -p1 "${FILESDIR}/unitycore-ldflags_fix.diff"
	find . -name "*.cmake" -exec sed -e 's:msg:message:g' -i '{}' \;
	qt5-build_src_prepare
	export PATH="${QT5_BINDIR}:${PATH}"
}

src_configure() {
	local PKG_CONFIG_PATH="/opt/phablet-preview/$(get_libdir)/pkgconfig:$PKG_CONFIG_PATH"
	local mycmakeargs="${mycmakeargs}
				-DCMAKE_BUILD_TYPE=debug
				-DCMAKE_INSTALL_PREFIX="/opt/phablet-preview"
				-DGTEST_ROOT="${WORKDIR}/gtest-${GTESTVER}"
				"
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install

	pushd "${CMAKE_BUILD_DIR}"
		insinto /opt/phablet-preview
		doins -r tests plugins
	popd

	exeinto /usr/bin
	doexe "${FILESDIR}/phablet-preview"
}
