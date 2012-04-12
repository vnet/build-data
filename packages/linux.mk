-include $(MU_BUILD_ROOT_DIR)/packages/linux-common.mk

# platforms.mk can change linux configs
# linux-configure_depend += $(foreach d,$(SOURCE_PATH_BUILD_DATA_DIRS),$(d)/platforms.mk)

# ARCH dependent initrd
linux_initrd_powerpc = arch/powerpc/boot/ramdisk.image.gz

# Add dependency for initrd if its built into linux image
linux_build_depend += $(linuxrc_initrd_image)

linux_build =									\
  cd $(PACKAGE_BUILD_DIR) ;							\
  : copy embedded initrd into place for platforms that support one ;		\
  [[ -n "$(linux_initrd_$(linux_arch))" ]]					\
    && mkdir -p "`dirname $(PACKAGE_BUILD_DIR)/$(linux_initrd_$(linux_arch))`"	\
    && cp $(linuxrc_initrd_image)						\
         $(PACKAGE_BUILD_DIR)/$(linux_initrd_$(linux_arch)) ;			\
  $(linux_make) $(MAKE_PARALLEL_FLAGS)						\
    $(if $($(PLATFORM)_linux_build_image),$($(PLATFORM)_linux_build_image),vmlinux)

linux_install =					\
  : nothing to do

linux_clean = rm -rf $(PACKAGE_BUILD_DIR)

