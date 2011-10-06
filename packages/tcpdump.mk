tcpdump_configure_depend = libpcap-install openssl-install

tcpdump_configure_args = --with-crypto=$(call package_install_dir_fn,openssl)

tcpdump_CPPFLAGS = $(call installed_includes_fn, libpcap openssl)
tcpdump_LDFLAGS = $(call installed_libs_fn, libpcap openssl)
