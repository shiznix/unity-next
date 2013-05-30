# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_DEPEND="2:2.7"

GTESTVER="1.6.0"

inherit base cmake-utils eutils python toolchain-funcs bzr ubuntu-versionator xdummy

DESCRIPTION="Fully converged Unity desktop for the phone, pc, tablet, tv"
HOMEPAGE="https://launchpad.net/unity/phablet-mods"
SRC_URI="http://googletest.googlecode.com/files/gtest-${GTESTVER}.zip"  # SRC_URI must be set before EBZR_REPO_URI
EBZR_PROJECT="unity"
EBZR_BRANCH="trunk"
EBZR_REPO_URI="lp:unity/phablet-mods"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="doc +branding pch test"

RDEPEND="dev-libs/dee:=
	dev-libs/libdbusmenu:=
	dev-libs/libunity-misc:=
	mir-base/mir
	>=unity-base/bamf-0.4.0:=
	>=unity-base/compiz-0.9.9:=
	>=unity-base/nux-4.0.0:=
	unity-base/unity-language-pack
	x11-themes/humanity-icon-theme
	x11-themes/unity-asset-pool"
DEPEND="dev-cpp/gtest
	dev-libs/boost
	dev-libs/dee
	dev-libs/dbus-glib
	dev-libs/glib:2
	dev-libs/libappindicator
	dev-libs/libdbusmenu
	dev-libs/libindicate[gtk,introspection]
	dev-libs/libindicate-qt
	>=dev-libs/libindicator-12.10.2
	=dev-libs/libunity-preview-9999
	dev-libs/libunity-misc
	dev-qt/qtdeclarative:5
	dev-python/gconf-python
	>=gnome-base/gconf-3.2.5
	gnome-base/gnome-desktop:3
	>=gnome-base/gnome-menus-3.6.0:3
	>=gnome-base/gnome-control-center-3.6.3
	>=gnome-base/gnome-settings-daemon-3.6.3
	>=gnome-base/gnome-session-3.6.0
	>=gnome-base/gsettings-desktop-schemas-3.6.0
	gnome-base/gnome-shell
	gnome-base/libgdu
	>=gnome-extra/polkit-gnome-0.105
	media-libs/clutter-gtk:1.0
	media-sound/pulseaudio
	sys-apps/dbus
	>=sys-devel/gcc-4.7.3
	>=unity-base/bamf-0.4.0
	>=unity-base/compiz-0.9.9
	unity-base/dconf-qt
	=unity-base/hud-preview-9999
	unity-base/nux
	unity-base/overlay-scrollbar
	x11-base/xorg-server[dmx]
	x11-libs/dee-qt[qt5]
	x11-libs/libXfixes
	x11-misc/appmenu-gtk
	x11-misc/appmenu-qt
	doc? ( app-doc/doxygen
		media-gfx/graphviz )
	test? ( dev-cpp/gmock
		dev-python/autopilot
		dev-util/dbus-test-runner
		sys-apps/xorg-gtest )"

pkg_pretend() {
	if [[ $(gcc-major-version) -lt 4 ]] || \
		( [[ $(gcc-major-version) -eq 4 && $(gcc-minor-version) -lt 7 ]] ) || \
			( [[ $(gcc-version) == "4.7" && $(gcc-micro-version) -lt 3 ]] ); then
				die "${P} requires an active >=gcc-4.7.3, please consult the output of 'gcc-config -l'"
	fi
}

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_unpack() {
	unpack ${A}
	bzr_src_unpack
}

src_prepare() {
	PATCHES+=( "${FILESDIR}/nopch_fix.diff" )
	base_src_prepare

	python_convert_shebangs -r 2 .

	sed -e "s:/desktop:/org/unity/desktop:g" \
		-i "com.canonical.Unity.gschema.xml" || die

	sed -e "s:Ubuntu Desktop:Unity Gentoo Desktop:g" \
		-i "panel/PanelMenuView.cpp" || die

	# Remove testsuite cmake installation #
	sed -e '/python setup.py install/d' \
			-i tests/CMakeLists.txt

	# Unset CMAKE_BUILD_TYPE env variable so that cmake-utils.eclass doesn't try to 'append-cppflags -DNDEBUG' #
	#       resulting in build failure with 'fatal error: unitycore_pch.hh: No such file or directory' #
	export CMAKE_BUILD_TYPE=none

	# Disable '-Werror'
	sed -i 's/[ ]*-Werror[ ]*//g' CMakeLists.txt services/CMakeLists.txt
}

src_configure() {
	local PKG_CONFIG_PATH="/opt/phablet-preview/$(get_libdir)/pkgconfig:$PKG_CONFIG_PATH"

	if use pch; then
		local mycmakeargs="${mycmakeargs} -Duse_pch=ON"
	else
		local mycmakeargs="${mycmakeargs} -Duse_pch=OFF"
	fi

	local mycmakeargs="${mycmakeargs}
				-DCMAKE_BUILD_TYPE=Debug
				-DCMAKE_INSTALL_PREFIX="/opt/phablet-preview"
				-DCOMPIZ_PLUGIN_INSTALL_TYPE=local
				-DGSETTINGS_LOCALINSTALL=ON
				-DGTEST_ROOT_DIR="${WORKDIR}/gtest-${GTESTVER}"
				-DGTEST_SRC_DIR="${WORKDIR}/gtest-${GTESTVER}/src/"
				"
	cmake-utils_src_configure
}

src_compile() {
	pushd ${CMAKE_BUILD_DIR}/UnityCore
		VERBOSE=1 emake || die
	popd
}

src_install() {
	pushd ${CMAKE_BUILD_DIR}/UnityCore
		emake DESTDIR="${D}" install
	popd
}
