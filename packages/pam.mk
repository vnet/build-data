pam_configure_depend = flex-install libtirpc-install

pam_configure_args = --disable-static

pam_configure_args += --includedir=$(PACKAGE_INSTALL_DIR)/include/security

pam_configure_env = libtirpc_LIBS="$(call installed_libs_fn,libtirpc)" libtirpc_CFLAGS="$(call installed_includes_fn,libtirpc)"

pam_make_args = NIS_LIBS=-ltirpc

# pam local functions for image install
pam_security_find_shared_libs_fn = \
  find $(1) \
    -regex '.*/security/[a-z_]+.so'

pam_security_select_files = \
  [[ -d lib$($(ARCH)_libdir) ]] \
    && $(call pam_security_find_shared_libs_fn,lib$($(ARCH)_libdir))

# install pam security plugin libraries. 
pam_image_install = \
  $(BUILD_ENV) ; \
  tmp=$(IMAGE_INSTALL_DIR) ; \
  cd $(2) ; \
  t="`$(pam_security_select_files) ; \
      echo "" ; \
      exit 0 ;`" ; \
  [[ -z "$$t" ]] || tar cf - $$t | tar xf - -C $${tmp} ;
