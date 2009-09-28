fcons_configure_depend = clib-install 

fcons_CPPFLAGS = $(call installed_includes_fn, clib)

fcons_LDFLAGS = $(call installed_libs_fn, clib)
