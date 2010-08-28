vlib-api_configure_depend = clib-install svm-install vlib-install

vlib-api_CPPFLAGS = $(call installed_includes_fn, clib svm vlib)
vlib-api_LDFLAGS = $(call installed_libs_fn, clib svm vlib)

vlib-api_top_srcdir = $(call find_source_fn,vlib-api)
