gdb_configure_depend = ncurses-install

gdb_cross_LDFLAGS = $(call installed_libs_fn, ncurses)
gdb_cross_CPPFLAGS = $(call installed_includes_fn, ncurses)

gdb_cross_env += LDFLAGS=$(gdb_cross_LDFLAGS)
gdb_cross_env += CPPFLAGS=$(gdb_cross_CPPFLAGS)
gdb_cross_env += CFLAGS="-g -O2 $(gdb_cross_CPPFLAGS) $(gdb_cross_LDFLAGS)"

gdb_configure_env = $(gdb_cross_env)

gdb_configure_args = --disable-nls
gdb_configure_args += --disable-multi-ice
gdb_configure_args += --disable-gdbtk
gdb_configure_args += --disable-netrom
gdb_configure_args += --disable-sim
gdb_configure_args += --disable-tui
gdb_configure_args += --disable-profiling
gdb_configure_args += --with-mmalloc=no
gdb_configure_args += --with-included-regex=no
gdb_configure_args += --with-included-gettext=no
gdb_configure_args += --with-uiout=no

# gdb currently does not compile with -Werror for gcc-3.4.2
gdb_configure_args += --disable-werror

gdb_target = $(TARGET)

gdb_configure_host_and_target = \
  --build=local --host=$(TARGET) --target=$(gdb_target)
