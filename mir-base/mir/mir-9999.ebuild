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

DEPEND="dev-libs/boost
	media-libs/mesa[egl,gbm,gles2,mir]
	x11-libs/libdrm"

src_prepare() {
	# Disable '-Werror' #
	sed -e 's/-Werror//g' \
		-i CMakeLists.txt

	# Fix missing iostream includes #
	epatch "${FILESDIR}/iostream_include_fix.diff"

	# Unset CMAKE_BUILD_TYPE env variable so that cmake-utils.eclass doesn't try to 'append-cppflags -DNDEBUG' #
	export CMAKE_BUILD_TYPE=none
}

src_install() {
	cmake-utils_src_install

	dodoc HACKING.md README.md COPYING
}
