# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
CROS_WORKON_COMMIT="f033a7b6e6cb5e9c24897f63a0eeaf4db345d112"
CROS_WORKON_TREE="c8c11d8a790912c888d5a7b97867b4c3959dcd7b"

EAPI=4
CROS_WORKON_PROJECT="chromiumos/third_party/wayland-demos"

inherit autotools autotools-utils cros-workon

DESCRIPTION="demos for wayland the (compositing) display server library"
HOMEPAGE="http://wayland.freedesktop.org"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="+poppler +svg +clients +simple-clients
	+compositor-drm +compositor-x11 +compositor-wayland compositor-openwfd"

DEPEND="x11-base/wayland
	>=media-libs/mesa-7.12_alpha1[gbm,gles2,wayland]
	x11-libs/pixman
	x11-libs/libxkbcommon
	media-libs/libpng
	|| ( media-libs/libjpeg-turbo media-libs/jpeg )
	compositor-drm? (
		>=sys-fs/udev-136
		>=x11-libs/libdrm-2.4.25
	)
	compositor-x11? (
		x11-libs/libxcb
		x11-libs/libX11
	)
	compositor-openwfd? (
		media-libs/owfdrm
	)
	clients? (
		dev-libs/glib:2
		>=x11-libs/cairo-1.10.0[opengl]
		|| ( x11-libs/gdk-pixbuf:2 <x11-libs/gtk+-2.20:2 )
		poppler? ( app-text/poppler[cairo] )
	)
	svg? ( gnome-base/librsvg )"

RDEPEND="${DEPEND}"

# FIXME: add with-poppler to wayland configure
myeconfargs=(
	# prefix with "wayland-" if not already
	"--program-transform-name='/^wayland-/!s/^/wayland-/'"
	$(use_enable clients)
	$(use_enable simple-clients)
	$(use_enable compositor-drm drm-compositor)
	$(use_enable compositor-x11 x11-compositor)
	$(use_enable compositor-wayland wayland-compositor)
	$(use_enable compositor-openwfd openwfd-compositor)
)

src_prepare()
{
	sed -i -e "/PROGRAMS/s/noinst/bin/" \
		{compositor,clients}"/Makefile.am" || \
		die "sed {compositor,clients}/Makefile.am failed!"

	eautoreconf
}

pkg_postinst()
{
	einfo "To run the wayland exmaple compositor as x11 client execute:"
	einfo "   DISPLAY=:0 EGL_PLATFORM=x11 EGL_DRIVER=egl_dri2 wayland-compositor"
	einfo
	einfo "Start the wayland clients with EGL_PLATFORM set to wayland:"
	einfo "   EGL_PLATFORM=wayland wayland-terminal"
	einfo
}
