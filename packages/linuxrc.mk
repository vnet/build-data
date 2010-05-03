# otherwise $(LD) uses ld instead of e.g. ppc-linux-ld
linuxrc_make_args = LD=$(TARGET)-ld

linuxrc_install_depend = $(call find_package_file_fn,linuxrc.conf.spp)

linuxrc_install_depend += $(linuxrc_platform_script)

linuxrc_platform_makedev_script = \
  $(call find_build_data_file_fn,packages/makedev-$(PLATFORM).sh)

linuxrc_install_depend += $(linuxrc_platform_makedev_script)

linuxrc_makedev =						\
  $(INSTALL_DIR)/linuxrc/sbin/mkinitrd_dev -d dev ;		\
  if [ ! -z "$(linuxrc_platform_makedev_script)" ]; then	\
    . $(linuxrc_platform_makedev_script) ;			\
  fi

linuxrc_make_initrd_fn_squashfs = \
  mksquashfs $(1) $(2) -all-root -no-duplicates

linuxrc_make_initrd_fn_nfs = \
  mksquashfs $(1) $(2) -all-root -no-duplicates

# linuxrc_initrd_size = initrd size in kilobytes (multiple of 1024 bytes)
linuxrc_initrd_size = 9216
linuxrc_make_initrd_fn_ext2 = \
  e2fsimage -d $(1) -f $(2) -s $(linuxrc_initrd_size)

# default
linuxrc_initrd_type = squashfs

linuxrc_initrd_image = $(INSTALL_DIR)/linuxrc/initrd.$(linuxrc_initrd_type)

linuxrc_platform_script = \
  $(call find_build_data_file_fn,packages/linuxrc-initrd-$(PLATFORM).sh)

if_eq_then_fn = $(if $(subst $(1),,$(2)),,$(3))

# linuxrc_install_depend += $(call if_eq_then_fn,$(linuxrc_initrd_type),ext2,$(PLATFORM_IMAGE_DIR)/ro.img)

linuxrc_initrd_image_install =							\
  @$(BUILD_ENV) ;								\
  linuxrc_install_dir=$(INSTALL_DIR)/linuxrc ;					\
  initrd_img="$${linuxrc_install_dir}/initrd.$(linuxrc_initrd_type)" ;		\
  rm -f $${initrd_img} ;							\
  : make platform-independant part of initrd ;					\
  conf="$(call find_package_file_fn,linuxrc,linuxrc.conf.spp)" ;		\
  if [ ! -f "$${conf}" ] ; then							\
    $(call build_msg_fn,Failed to find linuxrc.conf.spp in source path) ;	\
    exit 1;									\
  fi ;										\
  : strip linuxrc symbols ;							\
  linuxrc_tmp="`mktemp $${linuxrc_install_dir}/linuxrc-exe-XXXXX`" ;		\
  cp $${linuxrc_install_dir}/usr/libexec/linuxrc $${linuxrc_tmp} ;		\
  chmod +x $${linuxrc_tmp} ;							\
  $(TARGET)-strip $${linuxrc_tmp} ;						\
  : sign the linuxrc executable ;						\
  if [ "$(sign_executables)" = 'yes'					\
          -a -n "$($(PLATFORM)_public_key)" ] ; then				\
    sign $($(PLATFORM)_public_key) $($(PLATFORM)_private_key_passphrase) $${linuxrc_tmp} ;				\
  fi ;										\
  : use pre-processor to generate conf file ;					\
  conf_tmp="`mktemp $${linuxrc_install_dir}/linuxrc-conf-XXXXX`" ;		\
  env LINUXRC_INITRD_TYPE=$(linuxrc_initrd_type)				\
    spp -o $${conf_tmp} $${conf} ;						\
  : now build image ;								\
  tmp_dir="`mktemp -d $${linuxrc_install_dir}/linuxrc-image-XXXXXX`" ;		\
  chmod 0755 $${tmp_dir} ;							\
  trap "rm -rf $${tmp_dir}" err ;						\
  fakeroot /bin/bash -c "{							\
    set -eu$(BUILD_DEBUG) ;							\
    cd $${tmp_dir} ;								\
    $(linuxrc_makedev) ;							\
    sh $${linuxrc_install_dir}/sbin/mkinitrd					\
      -o $${tmp_dir}								\
      -d $${tmp_dir}/dev							\
      -l $${linuxrc_tmp}							\
      -c $${conf_tmp} ;								\
    : embedd read-only image for ext2 ;						\
    if [ "$(linuxrc_initrd_type)" = "ext2" ] ; then				\
      $(call rw_image_embed_ro_image_fn,ro.img) ;				\
    fi ;									\
    : add platform dependent stuff to initrd ;					\
    if [ ! -z "$(linuxrc_platform_script)" ] ; then				\
      . $(linuxrc_platform_script) ;						\
    fi ;									\
    $(call linuxrc_make_initrd_fn_$(linuxrc_initrd_type),			\
	$${tmp_dir},$${initrd_img}) ;						\
  }" ;										\
  : cleanup tmp directory ;							\
  echo rm -rf $${tmp_dir}

$(linuxrc_initrd_image): linuxrc-install
	$(linuxrc_initrd_image_install)

linuxrc_install =					\
  $(PACKAGE_MAKE)					\
	libexecdir=$(PACKAGE_INSTALL_DIR)/usr/libexec	\
	install
