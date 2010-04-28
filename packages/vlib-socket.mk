vlib-socket_configure_depend = clib-install svm-install vlib-install \
			       vlib-api-install vlib-memory-install

vlib-socket_CPPFLAGS = $(call installed_includes_fn, clib svm vlib vlib-api \
	vlib-memory)
vlib-socket_LDFLAGS = $(call installed_libs_fn, clib svm vlib vlib-api \
	vlib-memory)
