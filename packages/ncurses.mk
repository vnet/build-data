# Without this configure uses the cross compiler
#  to compile the terminfo database
ncurses_configure_args = --with-build-cc=gcc

# What kind of libraries we want
ncurses_configure_args += --with-shared --with-normal
ncurses_configure_args += --without-profile --without-debug

ncurses_configure_args += --enable-termcap --disable-database

ncurses_configure_args += --disable-widec --disable-colorfgbg \
                           --disable-bsdpad --disable-hashmap \
                           --disable-xmc-glitch \
	                   --without-gpm --without-ada --without-cxx \
	                   --without-cxx-binding --without-progs

# Override normal install because we need to make links
# include/term.h -> include/ncurses/term.h, etc.
ncurses_install = \
  $(PACKAGE_MAKE) $($(PACKAGE)_install_args) install ; \
  cd $(PACKAGE_INSTALL_DIR)/include ; \
  for i in term.h ncurses.h curses.h ; do \
    ln -sf ncurses/$$i $$i ; \
  done

# Remove unused stuff from install image
ncurses_image_install = \
  rm -f lib*/lib{menu,panel,form}*
