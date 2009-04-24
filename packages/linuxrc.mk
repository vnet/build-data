# otherwise $(LD) uses ld instead of e.g. ppc-linux-ld
linuxrc_make_args = LD=$(TARGET)-ld

linuxrc_install_depend = $(call find_package_file_fn,linuxrc.conf)

linuxrc_platform_script = \
  $(call find_build_data_file_fn,packages/linuxrc-initrd-$(PLATFORM).sh)

linuxrc_install_depend += $(linuxrc_platform_script)

linuxrc_platform_makedev_script = \
  $(call find_build_data_file_fn,packages/makedev-$(PLATFORM).sh)

linuxrc_install_depend += $(linuxrc_platform_makedev_script)

linuxrc_makedev =						\
  $(INSTALL_DIR)/linuxrc/sbin/mkinitrd_dev -d dev ;		\
  if [ ! -z "$(linuxrc_platform_makedev_script)" ]; then	\
    . $(linuxrc_platform_makedev_script) ;			\
  fi

linuxrc_install =								\
  $(PACKAGE_MAKE) libexecdir=$(PACKAGE_INSTALL_DIR)/usr/libexec install ;	\
  initrd_img="$(PACKAGE_INSTALL_DIR)/initrd.img" ;				\
  rm -f $${initrd_img} ;							\
  : make platform-independant part of initrd ;					\
  conf="$(call find_package_file_fn,linuxrc,linuxrc.conf)" ;			\
  if [ ! -f "$${conf}" ] ; then							\
    $(call build_msg_fn,Failed to find linuxrc.conf in source path) ;		\
    exit 1;									\
  fi ;										\
  : no need for symbols ;							\
  $(TARGET)-strip $(PACKAGE_INSTALL_DIR)/usr/libexec/linuxrc ;			\
  tmp_dir="`mktemp -d $(PACKAGE_INSTALL_DIR)/linuxrc-image-XXXXXX`" ;		\
  chmod 0755 $${tmp_dir} ;							\
  fakeroot /bin/bash -c "{							\
    set -eu$(BUILD_DEBUG) ;							\
    cd $${tmp_dir} ;								\
    $(linuxrc_makedev) ;							\
    sh -vx $(PACKAGE_INSTALL_DIR)/sbin/mkinitrd					\
      -o $${tmp_dir}								\
      -d $${tmp_dir}/dev							\
      -l $(PACKAGE_INSTALL_DIR)/usr/libexec/linuxrc				\
      -c $${conf} ;								\
    if [ ! -z "$(linuxrc_platform_script)" ] ; then				\
      . $(linuxrc_platform_script) ;						\
    fi ;									\
    rm -f $${initrd_img} ;							\
    mksquashfs $${tmp_dir} $${initrd_img} -all-root -no-duplicates ;		\
  }" ;										\
  : cleanup tmp directory ;							\
  rm -rf $${tmp_dir}
