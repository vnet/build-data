uw_configure_depend = clib-install

uw_CPPFLAGS = $(call installed_includes_fn, clib)

uw_LDFLAGS = $(call installed_libs_fn, clib)
