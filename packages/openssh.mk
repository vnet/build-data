openssh_configure_depend = zlib-install openssl-install

# Insure correct paths
openssh_configure_args = --prefix=/usr --libdir=/lib --sysconfdir=/etc/ssh

# Used for login; disable for size
openssh_configure_args += --disable-libutil

# openssl uses /dev/random so we don't need rand-helper
openssh_configure_args += --without-rand-helper

# zlib version check does not work when cross compiling
openssh_configure_args += --without-zlib-version-check

# make install doesn't use cross strip, we strip later anyway
openssh_configure_args += --disable-strip

# Don't create/install host keys since we're cross compiling
openssh_install = $(PACKAGE_MAKE) DESTDIR=$(PACKAGE_INSTALL_DIR) install-nokeys
