# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} )
GENTOO_DEPEND_ON_PERL="no"

inherit autotools eutils perl-module python-r1 versionator

DESCRIPTION="Library to support AppArmor userspace utilities"
HOMEPAGE="http://apparmor.net/"
SRC_URI="http://launchpad.net/apparmor/$(get_version_component_range 1-2)/${PV}/+download/apparmor-${PV}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc perl python static-libs"

RDEPEND="perl? ( dev-lang/perl )
	python? ( ${PYTHON_DEPS} )"

DEPEND="${RDEPEND}
	sys-devel/autoconf-archive
	sys-devel/bison
	sys-devel/flex
	doc? ( dev-lang/perl )
	perl? ( dev-lang/swig )
	python? ( dev-lang/swig	)"

S=${WORKDIR}/apparmor-${PV}/libraries/${PN}

src_prepare() {
	rm -r m4 || die "failed to remove bundled macros"
	# to force use of system macros
	eautoreconf

	use python && python_copy_sources
}

src_configure() {
	configure() {
		pushd "${BUILD_DIR}" > /dev/null
		econf \
			$(use_with perl) \
			$(use_with python) \
			$(use_enable static-libs static)
		popd > /dev/null
	}

	configure

	if use python ; then
		python_foreach_impl configure
	fi
}

src_compile() {
	emake -C src

	use doc && emake -C doc
	use perl && emake -C swig/perl

	if use python ; then
		compile_bindings() {
			emake -C "${BUILD_DIR}/swig/python"
		}
		python_foreach_impl compile_bindings
	fi
}

src_install() {
	emake -C src DESTDIR="${D}" install
	use doc && emake -C doc DESTDIR="${D}" install

	if use perl ; then
		emake -C swig/perl DESTDIR="${D}" install
		perlinfo
		insinto "${VENDOR_ARCH}"
		doins swig/perl/LibAppArmor.pm
	fi

	if use python ; then
		install_bindings() {
			emake -C "${BUILD_DIR}/swig/python" DESTDIR="${D}" install
		}
		python_foreach_impl install_bindings
	fi

	prune_libtool_files
}
