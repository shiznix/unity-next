EAPI=4
PYTHON_DEPEND="2:2.7 3:3.2"

inherit python cmake-utils bzr ubuntu-versionator	# bzr must inherit after cmake-utils

DESCRIPTION="Mir is a display server technology"
HOMEPAGE="https://launchpad.net/mir/"
EBZR_PROJECT="${PN}"
EBZR_BRANCH="trunk"
EBZR_REPO_URI="lp:${PN}"
SRC_URI=""

LICENSE="GPL-3 LGPL-3 MIT"
SLOT="0"
KEYWORDS=""

DEPEND="dev-cpp/gflags
	dev-cpp/glog
	dev-libs/boost
	media-libs/glm
	media-libs/mesa[egl,gbm,gles2,mir]
	sys-devel/gcc:4.7
	x11-libs/libdrm
	x11-libs/libxkbcommon"

pkg_pretend() {
	if [[ ( $(gcc-major-version) -eq 4 && $(gcc-minor-version) -ne 7 ) ]]; then
		die "${P} requires an active gcc:4.7, please consult the output of 'gcc-config -l'"
	fi
}

src_prepare() {
	# Disable '-Werror' #
	sed -e 's/-Werror//g' \
		-i CMakeLists.txt

	# Unset CMAKE_BUILD_TYPE env variable so that cmake-utils.eclass doesn't try to 'append-cppflags -DNDEBUG' #
	export CMAKE_BUILD_TYPE=none
}

src_configure() {
	# Disable gtest discovery tests as does not work #
	#   cmake/src/mir/mir_discover_gtest_tests.cpp:89: std::string {anonymous}::elide_string_left(const string&, std::size_t): Assertion `max_size >= 3' failed #
	local mycmakeargs="${mycmakeargs}
		-DDISABLE_GTEST_TEST_DISCOVERY=ON"
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	dodoc HACKING.md README.md COPYING.GPL COPYING.LGPL
}

pkg_postinst() {
	elog
	elog "Read /usr/share/doc/${P}/HACKING.md.bz2 for how to run the MIR display server"
	elog
}
