pcmciautils_configure_depend := sysfsutils-build
pcmciautils_build_depend := sysfsutils-install
pcmciautils_install_depend := sysfsutils-install

pcmciautils_top_srcdir = $(call find_source_fn,pcmciautils)

pcmciautils_configure = \
  cp $(pcmciautils_top_srcdir)/Makefile $(PACKAGE_BUILD_DIR); \
  mkdir -p $(PACKAGE_BUILD_DIR)/src		;\
  mkdir -p $(PACKAGE_BUILD_DIR)/udev		;\
  mkdir -p $(PACKAGE_BUILD_DIR)/build

pcmciautils_make_args = CROSS=$(TARGET)-
pcmciautils_make_args += top_srcdir=$(call find_source_fn,pcmciautils)

pcmciautils_make_parallel_fails = yes
pcmciautils_build = \
  export CPPFLAGS="-I$(call package_install_dir_fn,sysfsutils)/include -I$(pcmciautils_top_srcdir)/src"							 ;\
  export LDFLAGS="$(call installed_libs_fn, sysfsutils)"		 ;\
  make $(pcmciautils_make_args)						 ;\
  unset CPPFLAGS LDFLAGS

pcmciautils_install_args = prefix=$(prefix)
