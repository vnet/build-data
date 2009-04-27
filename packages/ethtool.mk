t_configure_depend = clib-install

t_CPPFLAGS = $(call installed_includes_fn, clib)

t_LDFLAGS = $(call installed_libs_fn, clib)
