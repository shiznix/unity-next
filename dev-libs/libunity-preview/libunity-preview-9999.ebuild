# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_1,3_2,3_3} )

VALA_MIN_API_VERSION="0.16"
VALA_MAX_API_VERSION="0.18"
VALA_USE_DEPEND="vapigen"

inherit autotools base eutils autotools python-r1 bzr ubuntu-versionator vala

DESCRIPTION="Library for instrumenting and integrating with all aspects of the Unity shell"
HOMEPAGE="https://code.launchpad.net/libunity/phablet"
EBZR_PROJECT="libunity"
EBZR_BRANCH="trunk"
EBZR_REPO_URI="lp:libunity/phablet"

LICENSE="GPL-3"
SLOT="0/9.0.2"
KEYWORDS=""
IUSE=""
RESTRICT="mirror"

RDEPEND="dev-libs/dee:=
	dev-libs/libdbusmenu:="
DEPEND="${RDEPEND}
	dev-libs/libgee:0
	x11-libs/gtk+:3
	$(vala_depend)"

src_prepare() {
	vala_src_prepare
	export VALA_API_GEN="$VAPIGEN"
	eautoreconf
}

src_configure() {
	python_copy_sources
	configuration() {
		econf --prefix=/opt/phablet-preview \
			--datadir=/opt/phablet-preview/share \
			--disable-debug || die
	}
	python_foreach_impl run_in_build_dir configuration
}

src_compile() {
	compilation() {
		emake || die
	}
	python_foreach_impl run_in_build_dir compilation
}

src_install() {
	installation() {
		emake DESTDIR="${D}" install
	}
	python_foreach_impl run_in_build_dir installation
	prune_libtool_files --modules

	use amd64 && \
		ln -s "${D}opt/phablet-preview/lib64" "${D}opt/phablet-preview/lib"
}
