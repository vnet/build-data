# final_prefix is the final location where the package will
# be installed (by spread-pacman-install) on the real hardware.

# target dependent configure args
# PLATFORM=qasmp
spread_configure_args_qasmp = --build=i386-unknown-linux-gnu
spread_prefix_qasmp = /tmp/spread
spread_install_args_qasmp =


# PLATFORM=qsp
spread_configure_args_qsp = --build=i386-unknown-linux-gnu
spread_prefix_qsp = /tmp/spread
spread_install_args_qsp =

# PLATFORM=qnative
spread_configure_args_qnative = 
spread_prefix_qnative = $(PACKAGE_INSTALL_DIR)
# DESTDIR is / only for native builds
spread_install_args_qnative = DESTDIR=/

# no PLATFORM specified translates to PLATFORM=native
spread_configure_args_native = 
spread_prefix_native = $(PACKAGE_INSTALL_DIR)
# DESTDIR is / only for native builds
spread_install_args_native = DESTDIR=/

# combine target specific args with general configure args
spread_configure_args = $(spread_configure_args_$(PLATFORM))

spread_configure_prefix = --prefix=$(spread_prefix_$(PLATFORM))

spread_install_args = $(spread_install_args_$(PLATFORM))

spread_configure =				\
  s=$(call find_source_fn,$(PACKAGE_SOURCE)) ;	\
  cd $(PACKAGE_BUILD_DIR) ;			\
  env $(CONFIGURE_ENV)				\
    $$s/configure				\
      $(if $(ARCH:native=),--host=$(TARGET),)	\
      $(spread_configure_prefix)	        \
      $(spread_configure_args)

spread_build = \
  $(MAKE)                                                         \
    -C $(PACKAGE_BUILD_DIR)                                       \
    $($(PACKAGE)_make_args)                                       \
    $(MAKE_PARALLEL_FLAGS)


# Remove any installed libtool .la files, so that dependent packages
# that use libtool don't get confused by paths embedded in the .la files
# that do not reflect the DESTDIR used in the install of spread.
# This is simpler than trying to "fix" the paths inside the .la files,
# since we won't be using the .la files on packman-installed builds anyway.
spread_instdir_qasmp = $(call package_install_dir_fn,spread)/tmp/spread
spread_instdir_qsp = $(call package_install_dir_fn,spread)/tmp/spread
spread_instdir_qnative = $(call package_install_dir_fn,spread)
spread_instdir_native = $(call package_install_dir_fn,spread)
spread_post_install = \
echo "INSTALLED IN" $(spread_instdir_$(PLATFORM)) ; \
  (cd $(spread_instdir_$(PLATFORM))/lib && find . -name '*.la' -print0 | xargs -0 rm -f)

