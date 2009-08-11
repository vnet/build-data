ompi_platform_dir = $(call find_source_fn,$(PACKAGE_SOURCE))/contrib/platform

# target dependent configure args
ompi_configure_args_ppc-q-linux = \
  --build=i386-unknown-linux-gnu \
  --with-platform=$(ompi_platform_dir)/cisco/hlfr/ebuild \
  --host=$(TARGET)

ompi_configure_args = $(ompi_configure_args_$(TARGET))
