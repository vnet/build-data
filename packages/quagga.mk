quagga_build_depend = routing-sw-install cm-install

quagga_configure_args += --disable-zebra
quagga_configure_args += --disable-doc
quagga_configure_args += --disable-ripd
quagga_configure_args += --disable-ripngd
quagga_configure_args += --disable-ospfd
quagga_configure_args += --disable-ospf6d
quagga_configure_args += --disable-watchquagga

quagga_CPPFLAGS = $(call installed_includes_fn, routing-sw)
quagga_CPPFLAGS += -I$(cm_instdir)/include/openrcm
quagga_CPPFLAGS += -I$(cm_instdir)/include/openrcm/include
quagga_CPPFLAGS += -I$(ompi_instdir)/include/openmpi

quagga_LDFLAGS = $(call installed_libs_fn, routing-sw)
quagga_LDFLAGS += -L$(ompi_instdir)/lib -L$(cm_instdir)/lib

quagga_CFLAGS += -g -DUSE_QYAL
