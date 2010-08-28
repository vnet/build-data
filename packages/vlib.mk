vlib_configure_depend = clib-install svm-install

vlib_CPPFLAGS = $(call installed_includes_fn, clib svm)
vlib_LDFLAGS = $(call installed_libs_fn, clib svm)

vlib_top_srcdir = $(call find_source_fn,vlib)
