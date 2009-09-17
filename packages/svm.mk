svm_configure_depend = clib-install

svm_CPPFLAGS = $(call installed_includes_fn, clib)

svm_LDFLAGS = $(call installed_libs_fn, clib)
