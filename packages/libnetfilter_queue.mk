libnetfilter_queue_configure_depend = libnfnetlink-install
libnetfilter_queue_CFLAGS = $(call installed_includes_fn, libnfnetlink) -include "asm/types.h"
libnetfilter_queue_LDFLAGS = $(call installed_libs_fn, libnfnetlink)
