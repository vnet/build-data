lighttpd_configure_depend = openssl-install zlib-install bzip2-install

lighttpd_configure_args += --with-openssl=$(INSTALL_DIR)/openssl
lighttpd_configure_args += --with-zlib=$(INSTALL_DIR)/zlib
lighttpd_configure_args += --with-bzip2=$(INSTALL_DIR)/bzip2

lighttpd_configure_args += --without-pcre

