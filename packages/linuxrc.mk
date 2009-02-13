# otherwise $(LD) uses ld instead of e.g. ppc-teak-linux-ld
linuxrc_make_args = LD=$(TARGET)-ld

linuxrc_install_depend = $(call find_package_file_fn,linuxrc.conf)

linuxrc_install =								\
  $(PACKAGE_MAKE) libexecdir=$(PACKAGE_INSTALL_DIR)/usr/libexec install ;	\
  i="$(PACKAGE_INSTALL_DIR)/initrd.img" ;					\
  rm -f $${i} ;									\
  : make platform-independant part of initrd ;					\
  conf="$(call find_package_file_fn,linuxrc,linuxrc.conf)" ;			\
  if [ ! -f "$${conf}" ] ; then							\
    $(call build_msg_fn,Failed to find linuxrc.conf in source path) ;		\
    exit 1;									\
  fi ;										\
  fakeroot /bin/bash -c "{							\
    $(PACKAGE_INSTALL_DIR)/sbin/mkinitrd_dev -d $(PACKAGE_INSTALL_DIR)/dev;	\
    $(PACKAGE_INSTALL_DIR)/sbin/mkinitrd					\
      -o $${i}									\
      -l $(PACKAGE_INSTALL_DIR)/usr/libexec/linuxrc				\
      -c $${conf} ;								\
  }"
