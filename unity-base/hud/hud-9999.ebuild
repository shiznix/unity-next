# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_DEPEND="2:2.7 3:3.2"
SUPPORT_PYTHON_ABIS="1"
VALA_MIN_API_VERSION="0.20"
VALA_USE_DEPEND="vapigen"

inherit cmake-utils distutils bzr ubuntu-versionator vala	# bzr must inherit after cmake-utils

DESCRIPTION="Backend for the Unity HUD"
HOMEPAGE="https://launchpad.net/hud"
EBZR_PROJECT="${PN}"
EBZR_BRANCH="trunk"
EBZR_REPO_URI="lp:${PN}"
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
			-DVAPI_GEN=$(type -P vapigen-0.20)"
	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
	pushd tools/hudkeywords
		distutils_src_compile
	popd
}

src_install() {
	cmake-utils_src_install
	pushd tools/hudkeywords
		distutils_src_install
	popd
}
