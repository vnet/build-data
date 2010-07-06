parted_configure_depend = e2fsprogs-install
parted_configure_args = --disable-device-mapper --without-readline

parted_CPPFLAGS = $(call installed_includes_fn, e2fsprogs)
parted_LDFLAGS = $(call installed_libs_fn, e2fsprogs)
