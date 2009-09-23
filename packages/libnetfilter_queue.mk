libnetfilter-queue_configure_depend = libnfnetlink-install
libnetfilter-queue_CFLAGS = $(call installed_includes_fn, libnfnetlink)
libnetfilter-queue_LDFLAGS = $(call installed_libs_fn, libnfnetlink)
