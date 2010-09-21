vlib_configure_depend = clib-install

vlib_CPPFLAGS = $(call installed_includes_fn, clib)
vlib_LDFLAGS = $(call installed_libs_fn, clib)

vlib_top_srcdir = $(call find_source_fn,vlib)
