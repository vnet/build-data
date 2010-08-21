svm_configure_depend = clib-install

svm_top_srcdir = $(call find_source_fn,svm)

svm_CPPFLAGS = -I$(clib_top_srcdir)

svm_LDFLAGS = -L$(BUILD_DIR)/clib
