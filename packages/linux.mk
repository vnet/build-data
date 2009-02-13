# Map our notion of ARCH to Linux kernel Makefile's.
LINUX_MAKEFILE_ARCH = \
   ${shell case '$(ARCH)' in \
      (i*86*) echo i386 ;; \
      (ppc*|powerpc*) echo powerpc ;; \
      (*) echo '$(ARCH)' ;; \
     esac }

LINUX_ARCH = \
  $(if $($(PLATFORM)_linux_arch),$($(PLATFORM)_linux_arch),$(LINUX_MAKEFILE_ARCH))

# Arch could be e.g. ppc7450 which we map to e.g. ppc
DEFAULT_LINUX_ARCH = \
   ${shell case '$(ARCH)' in \
      (i*86*) echo i386 ;; \
      (ppc*|powerpc*) echo ppc ;; \
      (*) echo '$(ARCH)' ;; \
     esac }

linux_build_dir = linux-$(PLATFORM)

LINUX_MAKE = \
  $(MAKE) -C $(call find_source_fn,linux) \
    O=$(PACKAGE_BUILD_DIR) \
    ARCH=$(LINUX_ARCH) \
    CROSS_COMPILE=$(TARGET)-

linux_config_files_for_platform =						\
  $(call find_package_file_fn,linux,linux-default-$(DEFAULT_LINUX_ARCH).config)	\
  $(call find_package_file_fn,linux,linux-$(ARCH).config)			\
  $(call find_package_file_fn,linux,linux-$(PLATFORM).config)

# Copy pre-built linux config into compile directory
# Move include files to install area for compiling glibc
linux_configure = \
  mkdir -p $(PACKAGE_BUILD_DIR) ; \
  : construct linux config from ARCH and PLATFORM specific pieces ; \
  b="`mktemp $(PACKAGE_BUILD_DIR)/.tmp-config-XXXXXX`" ; \
  cat $(linux_config_files_for_platform) >> $${b} ; \
  if [ '0' = `wc -c $${b} | awk '{ print $$1; }'` ]; then \
    $(call build_msg_fn,No Linux config for platform $(PLATFORM) or arch $(ARCH)) ; \
    exit 1; \
  fi ; \
  $(call build_msg_fn,Linux config for platform $(PLATFORM) from $(linux_config_files_for_platform)) ; \
  : compare config with last used config ; \
  l=$(PACKAGE_BUILD_DIR)/.last-config ; \
  c=$(PACKAGE_BUILD_DIR)/.config ; \
  cmp --quiet $$b $$l || { \
	cp $$b $$l ; \
	cp $$b $$c ; \
	$(LINUX_MAKE) oldconfig ; \
  } ; \
  $(LINUX_MAKE) Makefile prepare archprepare

# kernel build depends on config file fragments for platform
linux_build_depend = $(linux_config_files_for_platform)

# ARCH dependent initrd
linux_initrd_powerpc = arch/powerpc/boot/ramdisk.image.gz

# Add dependency for initrd if its built into linux image
ifneq (,$(linux_initrd_$(LINUX_ARCH)))
 linux_build_depend += linuxrc-install $(INSTALL_DIR)/linuxrc/initrd.img
endif

linux_build =									\
  cd $(PACKAGE_BUILD_DIR) ;							\
  : copy embedded initrd into place for platforms that support one ;		\
  [[ -n "$(linux_initrd_$(LINUX_ARCH))" ]]					\
    && mkdir -p "`dirname $(PACKAGE_BUILD_DIR)/$(linux_initrd_$(LINUX_ARCH))`"	\
    && cp $(INSTALL_DIR)/linuxrc/initrd.img					\
         $(PACKAGE_BUILD_DIR)/$(linux_initrd_$(LINUX_ARCH)) ;			\
  $(LINUX_MAKE) $(MAKE_PARALLEL_FLAGS)						\
    $(if $($(PLATFORM)_linux_build_image),$($(PLATFORM)_linux_build_image),vmlinux)

linux_update_config_fn = \
  @$(BUILD_ENV) ; \
  cd $(PACKAGE_BUILD_DIR) ; \
  tmp="`mktemp .config-XXXXXX`" ; \
  cp .config $${tmp} ; \
  $(LINUX_MAKE) $(1) ; \
  : copy back resulting config if changed ; \
  cmp --quiet $${tmp} .config \
    || cp .config $(call find_package_file_fn,linux-$(PLATFORM).config) ; \
  rm -f $${tmp}

linux-gconfig linux-xconfig linux-menuconfig: linux-configure
	$(call linux_update_config_fn, $(patsubst linux-%,%,$@))

linux_install = \
  cd $(PACKAGE_BUILD_DIR) ; \
  : nothing to do for now

linux_clean = rm -rf $(PACKAGE_BUILD_DIR)

