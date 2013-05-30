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
EBZR_PROJECT="unity-lens-people"
EBZR_BRANCH="trunk"
EBZR_REPO_URI="lp:unity-lens-people"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="dev-libs/dee:="
DEPEND="${RDEPEND}
	dev-libs/folks
	dev-libs/glib:2
	dev-libs/libgee
	=dev-libs/libunity-preview-9999
	$(vala_depend)"

src_prepare() {
	vala_src_prepare
	export VALA_API_GEN="$VAPIGEN"
	eautoreconf
}

src_configure() {
	local PKG_CONFIG_PATH="/opt/phablet-preview/$(get_libdir)/pkgconfig:$PKG_CONFIG_PATH"
	econf \
		--prefix=/opt/phablet-preview \
		--datadir=/opt/phablet-preview/share \
		--enable-localinstall
}

src_compile() {
	MAINTAINER_VALAFLAGS="--vapidir=/opt/phablet-preview/share/vala/vapi" make || die
}

src_install() {
	emake DESTDIR="${D}" install
}
