# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

EGIT_REPO_URI="http://git.chromium.org/chromiumos/third_party/${PN}.git"
EGIT_COMMIT="09fcd01301cd161e2a5d619933c14f79753108d6"

GIT_ECLASS="git-2"
EXPERIMENTAL="true"

inherit base autotools multilib flag-o-matic toolchain-funcs ${GIT_ECLASS}

OPENGL_DIR="xorg-x11"

MY_PN="${PN/m/M}"
MY_P="${MY_PN}-${PV/_/-}"
MY_SRC_P="${MY_PN}Lib-${PV/_/-}"

FOLDER="${PV/_rc*/}"
[[ ${PV/_rc*/} == ${PV} ]] || FOLDER+="/RC"

DESCRIPTION="OpenGL-like graphic library for Linux"
HOMEPAGE="http://mesa3d.sourceforge.net/"

#SRC_PATCHES="mirror://gentoo/${P}-gentoo-patches-01.tar.bz2"
SRC_URI="${SRC_PATCHES}"

# Most of the code is MIT/X11.
# ralloc is LGPL-3
# GLES[2]/gl[2]{,ext,platform}.h are SGI-B-2.0
LICENSE="MIT LGPL-3 SGI-B-2.0"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~ia64-linux ~x86-linux ~sparc-solaris ~x64-solaris ~x86-solaris"

INTEL_CARDS="i915 i965 intel"
RADEON_CARDS="r100 r200 r300 r600 radeon"
VIDEO_CARDS="${INTEL_CARDS} ${RADEON_CARDS} nouveau vmware"
for card in ${VIDEO_CARDS}; do
	IUSE_VIDEO_CARDS+=" video_cards_${card}"
done

IUSE="${IUSE_VIDEO_CARDS}
	bindist +classic d3d debug +egl g3dvl +gallium gbm gles1 gles2 +llvm +nptl openvg pax_kernel pic selinux shared-dricore +shared-glapi vdpau wayland xvmc kernel_FreeBSD"

REQUIRED_USE="
	d3d?    ( gallium )
	g3dvl?  ( gallium )
	llvm?   ( gallium )
	openvg? ( gallium )
	egl? ( shared-glapi )
	gallium? (
		video_cards_r300?   ( llvm )
		video_cards_radeon? ( llvm )
	)
	g3dvl? ( || ( vdpau xvmc ) )
	vdpau? ( g3dvl )
	xvmc?  ( g3dvl )
	video_cards_i915?   ( classic )
	video_cards_r100?   ( classic )
	video_cards_r200?   ( classic )
	video_cards_vmware? ( gallium )
"

LIBDRM_DEPSTRING=">=x11-libs/libdrm-2.4.24"
# not a runtime dependency of this package, but dependency of packages which
# depend on this package, bug #342393
EXTERNAL_DEPEND="
	>=x11-proto/dri2proto-2.6
	>=x11-proto/glproto-1.4.14
"
# keep correct libdrm and dri2proto dep
# keep blocks in rdepend for binpkg
RDEPEND="${EXTERNAL_DEPEND}
	!<x11-base/xorg-server-1.7
	!<=x11-proto/xf86driproto-2.0.3
	classic? ( app-admin/eselect-mesa )
	gallium? ( app-admin/eselect-mesa )
	>=app-admin/eselect-opengl-1.2.2
	dev-libs/expat
	gbm? ( sys-fs/udev )
	>=x11-libs/libX11-1.3.99.901
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXxf86vm
	d3d? ( app-emulation/wine )
	vdpau? ( >=x11-libs/libvdpau-0.4.1 )
	wayland? ( x11-base/wayland )
	xvmc? ( x11-libs/libXvMC )
	${LIBDRM_DEPSTRING}[video_cards_nouveau?,video_cards_vmware?]
	sys-devel/llvm
"
for card in ${INTEL_CARDS}; do
	RDEPEND="${RDEPEND}
		video_cards_${card}? ( ${LIBDRM_DEPSTRING}[video_cards_intel] )
	"
done

for card in ${RADEON_CARDS}; do
	RDEPEND="${RDEPEND}
		video_cards_${card}? ( ${LIBDRM_DEPSTRING}[video_cards_radeon] )
	"
done

DEPEND="${RDEPEND}
	=dev-lang/python-2*
	dev-libs/libxml2
	dev-util/pkgconfig
	sys-devel/bison
	sys-devel/flex
	x11-misc/makedepend
	>=x11-proto/xextproto-7.0.99.1
	x11-proto/xf86driproto
	x11-proto/xf86vidmodeproto
"

S="${WORKDIR}/${MY_P}"

# It is slow without texrels, if someone wants slow
# mesa without texrels +pic use is worth the shot
QA_EXECSTACK="usr/lib*/opengl/xorg-x11/lib/libGL.so*"
QA_WX_LOAD="usr/lib*/opengl/xorg-x11/lib/libGL.so*"

# Think about: ggi, fbcon, no-X configs

pkg_setup() {
	# gcc 4.2 has buggy ivopts
	if [[ $(gcc-version) = "4.2" ]]; then
		append-flags -fno-ivopts
	fi

	# recommended by upstream
	append-flags -ffast-math
}

src_unpack() {
	default
	git-2_src_unpack
}

src_prepare() {
	# apply patches
	if [[ -n ${SRC_PATCHES} ]]; then
		EPATCH_FORCE="yes" \
		EPATCH_SOURCE="${WORKDIR}/patches" \
		EPATCH_SUFFIX="patch" \
		epatch
	fi

	# FreeBSD 6.* doesn't have posix_memalign().
	if [[ ${CHOST} == *-freebsd6.* ]]; then
		sed -i \
			-e "s/-DHAVE_POSIX_MEMALIGN//" \
			configure.ac || die
	fi
	# Solaris needs some recent POSIX stuff in our case
	if [[ ${CHOST} == *-solaris* ]] ; then
		sed -i -e "s/-DSVR4/-D_POSIX_C_SOURCE=200112L/" configure.ac || die
		sed -i -e 's/uint/unsigned int/g' src/egl/drivers/glx/egl_glx.c || die
	fi

	base_src_prepare

	epatch "${FILESDIR}"/7.11-i915g-lie.patch
	epatch "${FILESDIR}"/7.11-i915g-disable-aapoint-aaline.patch
	epatch "${FILESDIR}"/7.11-mesa-st-no-flush-front.patch
	epatch "${FILESDIR}"/7.11-state_tracker-gallium-fix-crash-with-st_renderbuffer.patch

	eautoreconf
}

src_configure() {
	local myconf
	tc-getPROG PKG_CONFIG pkg-config

	if use !gallium && use !classic; then
		ewarn "You enabled neither classic nor gallium USE flags. No hardware"
		ewarn "drivers will be built."
	fi

	if use classic; then
	# Configurable DRI drivers
		driver_enable swrast

		# Intel code
		driver_enable video_cards_intel i915 i965

		# Nouveau code
		driver_enable video_cards_nouveau nouveau

		# ATI code
		driver_enable video_cards_radeon radeon r200
	fi

	if use gallium; then
	# Configurable gallium drivers
		# Intel code
		gallium_driver_enable video_cards_intel i915

		# Nouveau code
		gallium_driver_enable video_cards_nouveau nouveau

		# ATI code
		gallium_driver_enable video_cards_radeon r300 r600
	fi

	myconf+="
		$(use_enable gles1)
		$(use_enable gles2)
		$(use_enable egl)
	"
	if use egl; then
		myconf+="
			--with-egl-platforms=x11$(use wayland && echo ",wayland")$(use gbm && echo ",drm")

		"
		if ! use wayland; then
			myconf+="
				$(use_enable gallium gallium-egl)
			"
		fi
	fi

	export LLVM_CONFIG=${SYSROOT}/usr/bin/llvm-config

	# --with-driver=dri|xlib|osmesa || do we need osmesa?
	econf \
		--disable-option-checking \
		--with-driver=dri \
		--disable-glut \
		--without-demos \
		--enable-xcb \
		$(use_enable debug) \
		$(use_enable gbm) \
		$(use_enable nptl glx-tls) \
		$(use_enable !pic asm) \
		$(use_enable shared-dricore) \
		$(use_enable shared-glapi) \
		--with-dri-drivers=${DRI_DRIVERS} \
		--with-gallium-drivers=${GALLIUM_DRIVERS} \
		${myconf}
}

src_install() {
	base_src_install

	# Save the glsl-compiler for later use
	if ! tc-is-cross-compiler; then
		dobin "${S}"/src/glsl/glsl_compiler
	fi

	# Install config file for eselect mesa
	insinto /usr/share/mesa
	newins "${FILESDIR}/eselect-mesa.conf.7.12" eselect-mesa.conf

	# Remove redundant headers
	# GLUT thing
	rm -f "${D}"/usr/include/GL/glut*.h
	# Glew includes
	rm -f "${D}"/usr/include/GL/{glew,glxew,wglew}.h

	# Move libGL and others from /usr/lib to /usr/lib/opengl/blah/lib
	# because user can eselect desired GL provider.
	ebegin "Moving libGL and friends for dynamic switching"
		dodir /usr/$(get_libdir)/opengl/${OPENGL_DIR}/{lib,extensions,include}
		local x
		for x in "${ED}"/usr/$(get_libdir)/lib{EGL,GL,OpenVG}.{la,a,so*}; do
			if [ -f ${x} -o -L ${x} ]; then
				mv -f "${x}" "${ED}"/usr/$(get_libdir)/opengl/${OPENGL_DIR}/lib \
					|| die "Failed to move ${x}"
			fi
		done
		for x in "${ED}"/usr/include/GL/{gl.h,glx.h,glext.h,glxext.h}; do
			if [ -f ${x} -o -L ${x} ]; then
				mv -f "${x}" "${ED}"/usr/$(get_libdir)/opengl/${OPENGL_DIR}/include \
					|| die "Failed to move ${x}"
			fi
		done
	eend $?

	dodir /usr/$(get_libdir)/dri
	insinto "/usr/$(get_libdir)/dri/"
	insopts -m0755
	# install the gallium drivers we use
	local gallium_drivers_files=( nouveau_dri.so r300_dri.so r600_dri.so swrast_dri.so )
	for x in ${gallium_drivers_files[@]}; do
		if [ -f "${S}/$(get_libdir)/gallium/${x}" ]; then
			doins "${S}/$(get_libdir)/gallium/${x}"
		fi
	done

	# install classic drivers we use
	local classic_drivers_files=( i915_dri.so i965_dri.so nouveau_vieux_dri.so radeon_dri.so r200_dri.so )
	for x in ${classic_drivers_files[@]}; do
		if [ -f "${S}/$(get_libdir)/${x}" ]; then
			doins "${S}/$(get_libdir)/${x}"
		fi
	done
}

pkg_postinst() {
	# Switch to the xorg implementation.
	echo
	eselect opengl set --use-old ${OPENGL_DIR}
}

# $1 - VIDEO_CARDS flag
# other args - names of DRI drivers to enable
# TODO: avoid code duplication for a more elegant implementation
driver_enable() {
	case $# in
		# for enabling unconditionally
		1)
			DRI_DRIVERS+=",$1"
			;;
		*)
			if use $1; then
				shift
				for i in $@; do
					DRI_DRIVERS+=",${i}"
				done
			fi
			;;
	esac
}

# $1 - VIDEO_CARDS flag
# other args - names of DRI drivers to enable
gallium_driver_enable() {
	case $# in
		# for enabling unconditionally
		1)
			GALLIUM_DRIVERS+=",$1"
			;;
		*)
			if use $1; then
				shift
				for i in $@; do
					GALLIUM_DRIVERS+=",${i}"
				done
			fi
			;;
	esac
}
