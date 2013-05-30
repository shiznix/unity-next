# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_DEPEND="2:2.7 3:3.2"
SUPPORT_PYTHON_ABIS="1"
VALA_MIN_API_VERSION="0.20"
VALA_USE_DEPEND="vapigen"

inherit cmake-utils bzr ubuntu-versionator vala	# bzr must inherit after cmake-utils

DESCRIPTION="Backend for the Unity HUD"
HOMEPAGE="https://launchpad.net/hud"
EBZR_PROJECT="hud"
EBZR_BRANCH="trunk"
EBZR_REPO_URI="lp:hud"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="test"

RDEPEND="dev-libs/libdbusmenu:=
	unity-base/bamf:="
DEPEND="${RDEPEND}
	app-accessibility/pocketsphinx
	dev-db/sqlite:3
	dev-libs/dee
	>=dev-libs/glib-2.35.4
	dev-perl/XML-Parser
	gnome-base/dconf
	x11-libs/gtk+:3
	x11-libs/pango
	$(vala_depend)
	test? ( dev-util/dbus-test-runner )"

src_prepare() {
	vala_src_prepare

	# Stop cmake doing the job of distutils #
	sed -e '/add_subdirectory(hudkeywords)/d' \
		-i tools/CMakeLists.txt	
}

src_configure() {
	# Disable tests for now, needs dbusmenu-jsonloader-0.4.pc packaging #
	local mycmakeargs="${mycmakeargs}
			-DENABLE_TESTS=OFF
			-DVALA_COMPILER=$(type -P valac-0.20)
			-DVAPI_GEN=$(type -P vapigen-0.20)
			-DCMAKE_BUILD_TYPE=Debug
			-DCMAKE_INSTALL_PREFIX="/opt/phablet-preview"
			-DCMAKE_INSTALL_LIBDIR=lib
			-DLOCAL_INSTALL=ON
			-DGSETTINGS_COMPILE=OFF"
	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
}

src_install() {
	cmake-utils_src_install
}
