x11_configure_depend = clib-install

# for test programs
x11_CPPFLAGS = $(call installed_includes_fn, clib)
x11_LDFLAGS = $(call installed_libs_fn, clib)
