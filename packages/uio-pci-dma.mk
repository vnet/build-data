uio-pci-dma_configure = 				\
  rm -rf $(PACKAGE_BUILD_DIR) ;				\
  mkdir -p $(PACKAGE_BUILD_DIR) ;			\
  ln -sf $(call find_source_fn,uio-pci-dma)/* $(PACKAGE_BUILD_DIR)

# Eliot FIXME: this causes a recursive fakeroot screw-up
uio-pci-dma_configure_depend = # $(if $(is_native),,linux-build)

# point module at linux kernel
uio-pci-dma_make_vars = \
  $(if $(is_native),,LINUX_KERNEL_DIR=$(BUILD_DIR)/$(call package_build_dir_fn,linux))

# need to let kernel build system we are cross compiling
uio-pci-dma_make_vars += $(if $(is_native),,ARCH=$(LINUX_ARCH) CROSS_COMPILE=$(TARGET)-)

uio-pci-dma_build = \
  make -C $(PACKAGE_BUILD_DIR) $(uio-pci-dma_make_vars)

# install module into $(PACKAGE_INSTALL_DIR)/etc; avoid running depmod
uio-pci-dma_install =				\
  $(uio-pci-dma_build)				\
    DEPMOD="/no/thank/you"			\
    MODLIB=$(PACKAGE_INSTALL_DIR)		\
    INSTALL_MOD_DIR=etc				\
    modules_install 

uio-pci-dma-install-headers: uio-pci-dma-configure
	make -C $(BUILD_DIR)/uio-pci-dma MODLIB=$(INSTALL_DIR)/uio-pci-dma install_headers

