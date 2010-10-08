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
	                   --without-cxx-binding

# Remove unused stuff from install image
ncurses_image_install = \
  rm -f lib*/lib{menu,panel,form}*
