quagga_build_depend = routing-sw-install orcm-cisco-install

quagga_configure_args += --disable-zebra
quagga_configure_args += --disable-doc
quagga_configure_args += --disable-ripd
quagga_configure_args += --disable-ripngd
quagga_configure_args += --disable-ospfd
quagga_configure_args += --disable-ospf6d
quagga_configure_args += --disable-watchquagga

quagga_CPPFLAGS = $(call installed_includes_fn, routing-sw)
quagga_CPPFLAGS += $(call installed_includes_fn, orcm-cisco)/openrcm
quagga_CPPFLAGS += $(call installed_includes_fn, orcm-cisco)/openrcm/include
quagga_CPPFLAGS += $(call installed_includes_fn, ompi-cisco)/openmpi

quagga_LDFLAGS = $(call installed_libs_fn, routing-sw)
quagga_LDFLAGS += -L$(INSTALL_DIR)/orcm-cisco/lib \
		  -L$(INSTALL_DIR)/ompi-cisco/lib

quagga_CFLAGS += -g -DUSE_QYAL

quagga_image_include = echo bin etc lib*

quagga_image_exclude = lib*.a

