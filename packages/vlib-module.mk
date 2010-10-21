vlib-module_configure = 				\
  rm -rf $(PACKAGE_BUILD_DIR) ;				\
  mkdir -p $(PACKAGE_BUILD_DIR) ;			\
  ln -sf $(call find_source_fn,vlib-module)/* $(PACKAGE_BUILD_DIR)

vlib-module_build = cd $(PACKAGE_BUILD_DIR) && make

# install module into $(PACKAGE_INSTALL_DIR)/etc
vlib-module_install =								\
  cd $(PACKAGE_BUILD_DIR) &&							\
    make modules_install MODLIB=$(PACKAGE_INSTALL_DIR) INSTALL_MOD_DIR=etc