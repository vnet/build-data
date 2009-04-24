bash_configure_depend = readline-install ncurses-install

bash_configure_args = --without-bash-malloc --disable-multibyte
bash_configure_args += --with-installed-readline=$(INSTALL_DIR)/readline

#
# If you need a static bash uncomment the following line
#bash_configure_args += --enable-static-link

bash_CPPFLAGS = $(call installed_includes_fn, ncurses readline)
bash_LDFLAGS = $(call installed_libs_fn, ncurses readline)

bash_image_install = ln -sf /bin/bash bin/sh
