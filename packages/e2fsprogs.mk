e2fsprogs_configure_args = --with-ccopts=-fPIC
e2fsprogs_top_srcdir = $(call find_source_fn,e2fsprogs)

e2fsprogs_install = \
  cd $(PACKAGE_BUILD_DIR)/lib/et ; \
  make DESTDIR=$(DESTDIR) installdirs ; \
  cd $(PACKAGE_BUILD_DIR)/lib/uuid ; \
  make DESTDIR=$(DESTDIR) install; \
  cd $(PACKAGE_BUILD_DIR)/lib/blkid ; \
  make DESTDIR=$(DESTDIR) install
