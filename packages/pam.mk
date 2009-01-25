pam_configure_args = --disable-docdir
pam_configure_args += --disable-static

# pam local functions for image install
pam_security_find_shared_libs_fn = \
  find $(1) \
    -regex '.*/security/[a-z_]+.so'

pam_security_image_copy = \
  [[ -d lib$($(ARCH)_libdir) ]] \
    && $(call pam_security_find_shared_libs_fn,lib$($(ARCH)_libdir))

# install pam security plugin libraries. 
pam_image_install = \
  $(BUILD_ENV) ; \
  tmp=$(IMAGE_INSTALL_DIR) ; \
  cd $(2) ; \
  t="`$(pam_security_image_copy) ; \
      echo "" ; \
      exit 0 ;`" ; \
  [[ -z "$$t" ]] || tar cf - $$t | tar xf - -C $${tmp} ;
