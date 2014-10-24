# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit toolchain-funcs python-any-r1 ubuntu-versionator

MY_PN="lib${PN}"
MY_P="${MY_PN}_${PV}"
S="${WORKDIR}/${PN}-${PV}"

UURL="mirror://ubuntu/pool/universe/libj/lib${PN}"
URELEASE="utopic"
UVER_PREFIX="~rc2"

DESCRIPTION="C++ JSON reader and writer"
HOMEPAGE="http://jsoncpp.sourceforge.net/"
SRC_URI="${UURL}/${MY_P}${UVER_PREFIX}.orig.tar.gz
	${UURL}/${MY_P}${UVER_PREFIX}-${UVER}.debian.tar.gz"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="doc"
RESTRICT="mirror"

DEPEND="
	doc? (
		app-doc/doxygen
		${PYTHON_DEPS}
	)"
RDEPEND=""

S="${WORKDIR}/${PN}-src-${PV}-rc2"

pkg_setup() {
	ubuntu-versionator_pkg_setup
	use doc && python-any-r1_pkg_setup
}

cxx_wrapper() {
	set -- $(tc-getCXX) ${CXXFLAGS} ${CPPFLAGS} ${LDFLAGS} "$@"
	echo "$@"
	"$@"
}

src_compile() {
	# This is the soname that other distros use.
	local soname="libjsoncpp.so.0"

	cxx_wrapper src/lib_json/*.cpp -Iinclude -shared -fPIC \
		-Wl,-soname,${soname} -o libjsoncpp.so.${PV%_*} || die
	ln -sf libjsoncpp.so.${PV%_*} ${soname} || die
	ln -sf ${soname} libjsoncpp.so || die
}

src_install() {
	# Follow Debian, Ubuntu, Arch convention for headers location, bug #452234 .
	insinto /usr/include/jsoncpp
	doins -r include/json

	dolib.so libjsoncpp.so*

	if use doc; then
		${EPYTHON} doxybuild.py --doxygen=/usr/bin/doxygen || die
		dohtml dist/doxygen/jsoncpp*/*
	fi

	insinto /usr/lib/pkgconfig
	doins "${WORKDIR}"/debian/pkgconfig/*
}
