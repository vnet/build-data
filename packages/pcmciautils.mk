pcmciautils_configure_depend = sysfsutils-install

top_srcdir = $(call find_source_fn,pcmciautils)

pcmciautils_configure = \
  cp $(top_srcdir)/Makefile $(PACKAGE_BUILD_DIR); \
  mkdir -p $(PACKAGE_BUILD_DIR)/src		;\
  mkdir -p $(PACKAGE_BUILD_DIR)/udev		;\
  mkdir -p $(PACKAGE_BUILD_DIR)/build

pcmciautils_make_args = CROSS=$(TARGET)-
pcmciautils_make_args += prefix=$(INSTALL_DIR)/pcmciautils
pcmciautils_make_args += top_srcdir=$(call find_source_fn,pcmciautils)

pcmciautils_build = \
  export CPPFLAGS="-I$(INSTALL_DIR)/sysfsutils/include -I$(top_srcdir)/src";\
  export LDFLAGS="$(call installed_libs_fn, sysfsutils)"		 ;\
  make $(pcmciautils_make_args)						 ;\
  unset CPPFLAGS LDFLAGS
