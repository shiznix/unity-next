# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python3_4 )
VIRTUALX_REQUIRED=always

URELEASE="vivid"
inherit cmake-utils python-single-r1 virtualx ubuntu-versionator

UURL="mirror://ubuntu/pool/universe/u/${PN}"
UVER_PREFIX="+${UVER_RELEASE}.${PVR_MICRO}"

DESCRIPTION="QML plugin that exposes Scopes functionality to Unity shell"
HOMEPAGE="https://launchpad.net/unity-scopes-shell"
SRC_URI="${UURL}/${MY_P}${UVER_PREFIX}.orig.tar.gz
	${UURL}/${MY_P}${UVER_PREFIX}-${UVER}.diff.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="mirror"

DEPEND="app-misc/location-service
	dev-libs/dbus-cpp
	dev-qt/qtcore:5
	dev-qt/qtdeclarative:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	unity-base/ubuntu-system-settings-online-accounts
	unity-base/unity
	unity-base/unity-api
	unity-base/unity-scopes-api
	x11-libs/gsettings-qt"

S="${WORKDIR}/${PN}-${PV}${UVER_PREFIX}"
export QT_SELECT=5

pkg_setup() {
	ubuntu-versionator_pkg_setup
	python-single-r1_pkg_setup
}

src_prepare() {
	sed -e "s:python-py34:python-3.4:g" \
		-e "s:lib/python3/dist-packages/scope_harness:lib/${EPYTHON}/site-packages/scope_harness:g" \
			-i "src/python/scope_harness/CMakeLists.txt"
	cmake-utils_src_prepare
}

src_compile() {
	# 'make' needs to be run in a virtual Xserver so that qmlplugindump's #
	#       qmltypes generation can successfully spawn dbus #
	VIRTUALX_COMMAND=cmake-utils_src_compile virtualmake
}

src_install() {
	VIRTUALX_COMMAND=cmake-utils_src_install virtualmake
}
