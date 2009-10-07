topdir = $(call find_source_fn,pciutils)

pciutils_configure = \
  cp $(topdir)/Makefile $(PACKAGE_BUILD_DIR) ;	\
  mkdir -p $(PACKAGE_BUILD_DIR)/lib ;			\
  cp $(topdir)/lib/Makefile $(PACKAGE_BUILD_DIR)/lib

pciutils_make_args = CROSS_COMPILE=$(TARGET)-
pciutils_make_args += HOST=$(TARGET)
pciutils_make_args += topdir=$(call find_source_fn,pciutils)

pciutils_build = \
  export CPPFLAGS="-I$(TOOL_INSTALL_DIR)/include -I. -Ilib" ; \
  export LDFLAGS="$(call installed_libs_fn, zlib) -L$(topdir)/lib" ; \
  make $(pciutils_make_args) ; \
  unset CPPFLAGS LDFLAGS

pciutils_install_args = PREFIX=$(INSTALL_DIR)/pciutils
pciutils_install_args += STRIP=
