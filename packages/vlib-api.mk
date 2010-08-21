vlib-api_top_srcdir = $(call find_source_fn,vlib-api)

vlib-api_CPPFLAGS = -I$(clib_top_srcdir) -I$(svm_top_srcdir) -I$(vlib_top_srcdir)
