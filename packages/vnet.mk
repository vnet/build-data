vnet_configure_depend = vlib-install clib-install svm-install

vnet_CPPFLAGS = $(call installed_includes_fn, vlib clib svm)
vnet_LDFLAGS = $(call installed_libs_fn, vlib clib svm)
