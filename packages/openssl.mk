openssl_depend = zlib
$(call pkgPhaseDependMacro,openssl)

# Build shared libraries
openssl_configure_flags = shared

# openssl insists on using deprecated -m486 so we override it
# with the more modern -mcpu= to silence GCC warnings.
openssl_configure_flags += ${shell case '$(ARCH)' in \
                               (i?86) echo '-mcpu=$(ARCH)' ;; esac }

openssl_configure_flags += --prefix="$(PACKAGE_INSTALL_DIR)"

openssl_configure = \
  rm -rf $(PACKAGE_BUILD_DIR) ; \
  mkdir -p $(PACKAGE_BUILD_DIR) ; \
  cd $(PACKAGE_BUILD_DIR) ; \
  : Copy in sources since openssl does not use GNU tools ; \
  cp --no-dereference --recursive --symbolic-link \
    $(call find_source_fn,openssl)/* . ; \
  ./Configure \
    ${shell case '$(BASIC_ARCH)' in \
          (i?86) echo linux-elf ;; \
	  (ppc) echo linux-ppc ;; \
          (*) echo 'linux-$(NATIVE_ARCH)' ;; esac } \
    -I$(INSTALL_DIR)/zlib/include \
    $(openssl_configure_flags)

OPENSSL_SHLIB_VERSION = ${shell \
  grep 'define SHLIB_VERSION_NUMBER' \
       $(call find_source_fn,openssl)/crypto/opensslv.h \
  | cut --fields=3 --delimiter=' ' \
  | sed 's/"//g' }

openssl_top_srcdir = $(call find_source_fn,openssl)

openssl_make_args += LD='$(TARGET_PREFIX)ld' \
                     AR='$(TARGET_PREFIX)ar r' \
	             CC='$(TARGET_PREFIX)gcc' \
                     RANLIB='$(TARGET_PREFIX)ranlib'

# gives make errors
openssl_make_parallel_fails = yes

openssl_image_include = echo bin $(arch_lib_dir) ssl
openssl_image_exclude = $(arch_lib_dir)/lib*.a

openssl_post_install =							    \
  if [ "$(arch_lib_dir)" != "lib" ] ; then				    \
     mkdir -p $(PACKAGE_INSTALL_DIR)/$(arch_lib_dir) ;			    \
     cd $(PACKAGE_INSTALL_DIR)/lib		     ;			    \
     tar cf - . | ( cd $(PACKAGE_INSTALL_DIR)/$(arch_lib_dir); tar xf - ) ; \
  fi 
