# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_DEPEND="2:2.7 3:3.2"
SUPPORT_PYTHON_ABIS="1"

inherit distutils bzr ubuntu-versionator

DESCRIPTION="Mock lens as part of phablet-extras for the Unity desktop"
HOMEPAGE="https://launchpad.net/unity-lens-mock"
EBZR_PROJECT="${PN}"
EBZR_BRANCH="trunk"
EBZR_REPO_URI="lp:phablet-extras/${PN}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="dev-libs/dee:="
DEPEND="${RDEPEND}
	dev-libs/libunity"
