# otherwise $(LD) uses ld instead of e.g. ppc-teak-linux-ld
linuxrc_make_args = LD=$(TARGET)-ld

linuxrc_install_depend = $(call find_package_file_fn,linuxrc.conf)

linuxrc_install =								\
  $(PACKAGE_MAKE) libexecdir=$(INSTALL_DIR)/linuxrc/usr/libexec install ;	\
  i="$(INSTALL_DIR)/linuxrc/initrd.img" ;					\
  rm -f $${i} ;									\
  : make platform-independant part of initrd ;					\
  conf="$(call find_package_file_fn,linuxrc,linuxrc.conf)" ;			\
  if [ ! -f "$${conf}" ] ; then							\
    $(call build_msg_fn,Failed to find linuxrc.conf in source path) ;		\
    exit 1;									\
  fi ;										\
  fakeroot /bin/bash -c "{							\
    $(INSTALL_DIR)/linuxrc/sbin/mkinitrd_dev -d dev;				\
    $(INSTALL_DIR)/linuxrc/sbin/mkinitrd					\
      -o $${i}									\
      -l $(INSTALL_DIR)/linuxrc/usr/libexec/linuxrc				\
      -c $${conf} ;								\
  }"
