# final_prefix is the final location where the package will
# be installed (by ompi-pacman-install) on the real hardware.
ompi_final_prefix = /tmp/ompi

ompi_platform_dir = $(call find_source_fn,$(PACKAGE_SOURCE))/contrib/platform

ompi_configure_depend = 

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
  --with-platform=$(ompi_platform_file_$(target))

ompi_configure_prefix = --prefix=$(ompi_final_prefix)

ompi_configure =				\
  s=$(call find_source_fn,$(PACKAGE_SOURCE)) ;	\
  if [ ! -f $$s/configure ] ; then		\
    cd $$s ;					\
    ./autogen.sh -no-ompi ;			\
  fi ;						\
  cd $(PACKAGE_BUILD_DIR) ;			\
  env $(CONFIGURE_ENV)				\
    $$s/configure				\
      $(if $(ARCH:native=),--host=$(TARGET),)	\
      $(ompi_configure_prefix)			\
      $(ompi_configure_args)

ompi_install_args = DESTDIR='$(PACKAGE_INSTALL_DIR)'

ompi_build = \
  if [ -z "$(TARGET)" ] ; then                                    \
    if [ -L $(ompi_final_prefix) ] ; then                              \
      rm $(ompi_final_prefix) ;                                        \
    fi ;                                                          \
  fi ;                                                            \
  $(MAKE)                                                         \
    -C $(PACKAGE_BUILD_DIR)                                       \
    $($(PACKAGE)_make_args)                                       \
    $(MAKE_PARALLEL_FLAGS) ;                                      \
  if [ -z "$(TARGET)" ] ; then                                    \
    ln -s $(PACKAGE_INSTALL_DIR)$(ompi_final_prefix) $(ompi_final_prefix) ; \
  fi


# Remove any installed libtool .la files, so that dependent packages
# that use libtool don't get confused by paths embedded in the .la files
# that do not reflect the DESTDIR used in the install of ompi.
# This is simpler than trying to "fix" the paths inside the .la files,
# since we won't be using the .la files on the CRS anyway.
ompi_post_install = \
  rm $(PACKAGE_INSTALL_DIR)/$(ompi_final_prefix)/*/*.la ; \
  cp -p $(ompi_platform_file_$(TARGET)).conf $(PACKAGE_INSTALL_DIR)/$(ompi_final_prefix)/etc/openmpi-mca-params.conf

