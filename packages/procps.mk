procps_configure_depend = ncurses-configure
procps_build_depend = ncurses-install

procps_CPPFLAGS = $(call installed_includes_fn, ncurses)

procps_LDFLAGS = -L$(BUILD_DIR)/ncurses/lib
