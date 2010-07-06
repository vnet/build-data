e2fsprogs_configure_args = --with-ccopts=-fPIC

e2fsprogs_install = \
  cd $(PACKAGE_BUILD_DIR)/lib/et ; \
  make installdirs ; \
  cd $(PACKAGE_BUILD_DIR)/lib/uuid ; \
  make install; \
  cd $(PACKAGE_BUILD_DIR)/lib/blkid ; \
  make install
