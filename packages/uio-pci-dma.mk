uio-pci-dma_configure_depend = $(if $(is_native),,linux-build)

uio-pci-dma_configure = 				\
  rm -rf $(PACKAGE_BUILD_DIR) ;				\
  mkdir -p $(PACKAGE_BUILD_DIR) ;			\
  ln -sf $(call find_source_fn,uio-pci-dma)/* $(PACKAGE_BUILD_DIR)

uio-pci-dma_linux_dir = $(if $(is_native),,LINUX_KERNEL_DIR=$(BUILD_DIR)/$(call package_build_dir_fn,linux))

uio-pci-dma_build = \
  make -C $(PACKAGE_BUILD_DIR) $(uio-pci-dma_linux_dir)

# install module into $(PACKAGE_INSTALL_DIR)/etc; avoid running depmod
uio-pci-dma_install =								\
  $(uio-pci-dma_build) \
    modules_install DEPMOD="/no/thank/you" MODLIB=$(PACKAGE_INSTALL_DIR) INSTALL_MOD_DIR=etc