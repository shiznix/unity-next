# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
GNOME2_LA_PUNT="yes"

VALA_MIN_API_VERSION="0.20"
VALA_USE_DEPEND="vapigen"

inherit autotools eutils gnome2 bzr ubuntu-versionator vala

DESCRIPTION="People lens for the Unity desktop"
HOMEPAGE="https://launchpad.net/unity-lens-people"
SRC_URI=	# Reset so gnome2 eclasses don't clobber (inherit order makes no difference)
EBZR_PROJECT="${PN}"
EBZR_BRANCH="trunk"
EBZR_REPO_URI="lp:${PN}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="dev-libs/dee:="
DEPEND="${RDEPEND}
	dev-libs/folks
	dev-libs/glib:2
	dev-libs/libgee
	=dev-libs/libunity-9999
	$(vala_depend)"

src_prepare() {
	vala_src_prepare
	export VALA_API_GEN="$VAPIGEN"
	eautoreconf
}
