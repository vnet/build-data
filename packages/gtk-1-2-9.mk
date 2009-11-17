gtk-1-2-9_configure_depend = glib-1-2-9-install

gtk-1-2-9_configure_args =				\
  --with-glib-prefix=$(INSTALL_DIR)/glib-1-2-9		\
  --with-glib-exec-prefix=$(INSTALL_DIR)/glib-1-2-9 

gtk-1-2-9_configure_args += --disable-glibtest

