ompi_platform_dir = $(call find_source_fn,$(PACKAGE_SOURCE))/contrib/platform

# target dependent configure args
# PLATFORM=qasmp
ompi_configure_args_ppc-q-linux = \
  --build=i386-unknown-linux-gnu

# PLATFORM=qsp
ompi_configure_args_ppc-qsp-linux = \
  --build=i386-unknown-linux-gnu

# PLATFORM=native, NOTE: $(TARGET) is the empty string
ompi_configure_args_ = 

# combine target specific args with general configure args
ompi_configure_args = $(ompi_configure_args_$(TARGET)) \
  --with-platform=$(ompi_platform_dir)/cisco/hlfr/ebuild
