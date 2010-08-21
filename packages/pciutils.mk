pciutils_top_srcdir = $(call find_source_fn,pciutils)

pciutils_build_depend = zlib-install

pciutils_configure = \
  cp $(pciutils_top_srcdir)/Makefile $(PACKAGE_BUILD_DIR) ;	\
  mkdir -p $(PACKAGE_BUILD_DIR)/lib ;			\
  cp $(pciutils_top_srcdir)/lib/Makefile $(PACKAGE_BUILD_DIR)/lib

pciutils_make_args = CROSS_COMPILE=$(TARGET)-
pciutils_make_args += HOST=$(TARGET)
pciutils_make_args += topdir=$(call find_source_fn,pciutils)

pciutils_build = \
  export CPPFLAGS="-I$(TOOL_INSTALL_DIR)/include -I. -Ilib" ; \
  export LDFLAGS="$(call installed_libs_fn, zlib) -L$(pciutils_top_srcdir)/lib" ; \
  make $(pciutils_make_args) ; \
  unset CPPFLAGS LDFLAGS

pciutils_install_args = PREFIX=$(prefix)
pciutils_install_args += STRIP=
