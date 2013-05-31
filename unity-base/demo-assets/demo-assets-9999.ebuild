# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils gnome2 bzr ubuntu-versionator

DESCRIPTION="Sample data and scripts for the phablet project"
HOMEPAGE="https://launchpad.net/demo-assets"
SRC_URI=
EBZR_PROJECT="${PN}"
EBZR_BRANCH="trunk"
EBZR_REPO_URI="lp:${PN}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="unity-lenses/unity-lens-mock"
DEPEND="${RDEPEND}"

src_prepare() {
	:
}

src_configure() {
	:
}

src_compile() {
	:
}

src_install() {
	exeinto /usr/bin/
	doexe usr/bin/manage-address-books usr/bin/inject-data-into-friends-model

	insinto /usr/share/dbus-1
	doins -r services

	insinto /usr/share/unity
	doins -r lenses

	insinto /usr/share/demo-assets
	doins -r videos telephony-app pictures.tgz shell contacts-data
}
