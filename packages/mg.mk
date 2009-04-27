mg_configure_depend = ncurses-install

mg_CPPFLAGS = $(call installed_includes_fn, ncurses)

mg_LDFLAGS = $(call installed_libs_fn, ncurses)
