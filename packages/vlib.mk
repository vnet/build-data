vlib_depend = svm
$(call pkgPhaseDependMacro,vlib)

vlib_top_srcdir = $(call find_source_fn,vlib)

vlib_CPPFLAGS = -I$(vlib_top_srcdir)/../clib

vlib_LDFLAGS = -L$(BUILD_DIR)/clib -L$(BUILD_DIR)/svm 
