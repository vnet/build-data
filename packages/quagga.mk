quagga_build_depend = cm-install

quagga_configure_args += --disable-zebra
quagga_configure_args += --disable-doc
quagga_configure_args += --disable-ripd
quagga_configure_args += --disable-ripngd
quagga_configure_args += --disable-ospfd
quagga_configure_args += --disable-ospf6d
quagga_configure_args += --disable-watchquagga

quagga_CPPFLAGS = $(call installed_includes_fn, routing-sw)
quagga_LDFLAGS = $(call installed_libs_fn, routing-sw)

quagga_CPPFLAGS += -I$(PACKAGE_INSTALL_DIR)/../cm/tmp/cm/include/openrcm
quagga_CPPFLAGS += -I$(PACKAGE_INSTALL_DIR)/../cm/tmp/cm/include/openrcm/include
quagga_CPPFLAGS += -I$(PACKAGE_INSTALL_DIR)/../ompi/tmp/ompi/include/openmpi

quagga_CFLAGS += -g

quagga_make_args += INSTALL_DIR=$(PACKAGE_INSTALL_DIR)
