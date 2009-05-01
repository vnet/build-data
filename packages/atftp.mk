atftp_configure_depend = readline-install

atftp_CPPFLAGS = $(call installed_includes_fn, readline)
atftp_LDFLAGS = $(call installed_libs_fn, readline)
