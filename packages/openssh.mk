openssh_configure_depend = openssl-install zlib-install

openssh_CPPFLAGS += $(call installed_includes_fn,zlib openssl)
openssh_LDFLAGS = $(call installed_libs_fn,zlib)

# openssl does not honor lib64 for biarch platforms so we can't use
# installed_libs_fn
openssh_LDFLAGS += -L$(INSTALL_DIR)/openssl/lib

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
