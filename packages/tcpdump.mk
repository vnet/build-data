tcpdump_configure_depend = libpcap-install

tcpdump_CPPFLAGS = $(call installed_includes_fn, libpcap)
tcpdump_LDFLAGS = $(call installed_libs_fn, libpcap)
