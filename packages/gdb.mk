gdb_configure_depend = ncurses-install zlib-install

gdb_LDFLAGS = $(call installed_libs_fn, ncurses zlib)
gdb_CPPFLAGS = $(call installed_includes_fn, ncurses zlib)

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
gdb_configure_args += --without-expat
gdb_configure_args += --with-curses

# gdb currently does not compile with -Werror for gcc-3.4.2
gdb_configure_args += --disable-werror

gdb_target = $(TARGET)

gdb_configure_host_and_target = \
  --host=$(TARGET) --target=$(gdb_target)
