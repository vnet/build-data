# more etc. use -lncurses
util-linux_configure_depend = ncurses-install

# we use sysvinit
util-linux_configure_args += --disable-init

util-linux_configure_args += --disable-partx

# enable login 
util-linux_configure_args += --without-pam
util-linux_configure_args += --enable-login-utils

util-linux_CPPFLAGS = $(call installed_includes_fn, ncurses)
util-linux_CPPFLAGS += $(call installed_includes_fn, pam)

util-linux_LDFLAGS = $(call installed_libs_fn, ncurses)
util-linux_LDFLAGS += $(call installed_libs_fn, pam)

