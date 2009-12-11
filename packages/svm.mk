svm_configure_depend = clib-install elog-install

svm_CPPFLAGS = $(call installed_includes_fn, clib elog)

svm_LDFLAGS = $(call installed_libs_fn, clib elog)
