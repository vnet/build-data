uio-pci-dma_configure =						\
  rm -rf $(PACKAGE_BUILD_DIR) ;					\
  mkdir -p $(PACKAGE_BUILD_DIR) ;				\
  ln -sf $(call find_source_fn,uio-pci-dma)/* $(PACKAGE_BUILD_DIR)

uio-pci-dma_build = cd $(PACKAGE_BUILD_DIR) && make

# install module into $(PACKAGE_INSTALL_DIR)/etc
uio-pci-dma_install =								\
  cd $(PACKAGE_BUILD_DIR) &&							\
    make modules_install MODLIB=$(PACKAGE_INSTALL_DIR) INSTALL_MOD_DIR=etc