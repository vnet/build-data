lighttpd_configure_depend = openssl-install

lighttpd_configure_args += --with-openssl=$(INSTALL_DIR)/openssl
