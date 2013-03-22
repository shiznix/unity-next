unity-next
==========

Gentoo overlay stub for the developing Canonical Phablet project - fully converged Unity for phone, pc, tablet, tv

* It is necessary to mask certain packages that would normally be emerged from the main portage tree:

	ln -s /usr/local/portage/unity-next/unity-next-portage.pmask /etc/portage/package.mask/unity-next-portage.pmask
