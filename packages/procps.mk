procps_configure_depend = ncurses-install

procps_CPPFLAGS = $(call installed_includes_fn, ncurses)

procps_LDFLAGS = $(call installed_libs_fn, ncurses)
