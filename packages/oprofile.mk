oprofile_configure_depend = popt-install binutils-install zlib-install
oprofile_CPPFLAGS = $(call installed_includes_fn, popt binutils zlib)
oprofile_LDFLAGS = $(call installed_libs_fn, popt binutils zlib)

# libiberty.a lands in /lib
oprofile_LDFLAGS += -L$(INSTALL_DIR)/binutils/lib -L$(INSTALL_DIR)/binutils/bfd
