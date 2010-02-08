# final_prefix is the final location where the package will
# be installed (by ompi-pacman-install) on the real hardware.

ompi_platform_dir = $(call find_source_fn,$(PACKAGE_SOURCE))/contrib/platform

ompi_configure_depend = 

ompi_prefix=$(if $(TARGET),/tmp/ompi,$(PACKAGE_INSTALL_DIR))

# target dependent configure args
# PLATFORM=qasmp
ompi_configure_args_ppc-q-linux = \
  --build=i386-unknown-linux-gnu
ompi_platform_file_ppc-q-linux = $(ompi_platform_dir)/cisco/ebuild/hlfr

# PLATFORM=qsp
ompi_configure_args_ppc-qsp-linux = \
  --build=i386-unknown-linux-gnu
ompi_platform_file_ppc-qsp-linux = $(ompi_platform_dir)/cisco/ebuild/hlfr

# PLATFORM=native, NOTE: $(TARGET) is the empty string
ompi_configure_args_ = 
ompi_platform_file_ = $(ompi_platform_dir)/cisco/ebuild/native

# combine target specific args with general configure args
ompi_configure_args = $(ompi_configure_args_$(TARGET)) \
  --with-platform=$(ompi_platform_file_$(TARGET))

ompi_configure_prefix = --prefix=$(ompi_prefix)

# Have to 'touch ompi/aclocal.m4' because of git's bizarre
# timestamp habits - if we don't, then OMPI's build system
# is triggered to re-run autogen etc, which causes the
# build to crash
ompi_configure =				\
  s=$(call find_source_fn,$(PACKAGE_SOURCE)) ;	\
  cd $(PACKAGE_BUILD_DIR) ;			\
  env $(CONFIGURE_ENV)				\
    $$s/configure				\
      $(if $(ARCH:native=),--host=$(TARGET),)	\
      $(ompi_configure_prefix)			\
      $(ompi_configure_args)

# DESTDIR is / only for native builds
ompi_destdir = $(if $(TARGET),$(PACKAGE_INSTALL_DIR),/)
ompi_install_args = DESTDIR=$(ompi_destdir)

ompi_build = \
  pushd $(PACKAGE_BUILD_DIR) ;                                    \
  find . -exec /bin/touch {} \;  ;                                \
  popd ;                                                          \
  $(MAKE)                                                         \
    -C $(PACKAGE_BUILD_DIR)                                       \
    $($(PACKAGE)_make_args)                                       \
    $(MAKE_PARALLEL_FLAGS)


# Remove any installed libtool .la files, so that dependent packages
# that use libtool don't get confused by paths embedded in the .la files
# that do not reflect the DESTDIR used in the install of ompi.
# This is simpler than trying to "fix" the paths inside the .la files,
# since we won't be using the .la files on the CRS anyway.
ompi_instdir = $(call package_install_dir_fn,ompi)$(if $(TARGET),/tmp/ompi)
ompi_post_install = \
  (cd $(ompi_instdir)/lib && find . -name '*.la' -print0 | xargs -0 rm -f) ; \
  cp -p $(ompi_platform_file_$(TARGET)).conf \
	$(ompi_instdir)/etc/openmpi-mca-params.conf ; \
  echo "BE SURE TO ADD $(ompi_prefix)/bin to PATH"; \
  echo "  AND $(ompi_prefix)/lib to LD_LIBRARY_PATH"
