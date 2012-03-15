# more etc. use -lncurses
util-linux_configure_depend = ncurses-install pam-install

# we use sysvinit
util-linux_configure_args += --disable-init

util-linux_configure_args += --disable-partx

util-linux_configure_args += --disable-cramfs
util-linux_configure_args += --disable-elvtune
util-linux_configure_args += --disable-last
util-linux_configure_args += --disable-mesg
util-linux_configure_args += --disable-partx
util-linux_configure_args += --disable-raw
util-linux_configure_args += --disable-rdev
util-linux_configure_args += --disable-rename
util-linux_configure_args += --disable-schedutils
util-linux_configure_args += --disable-wall
util-linux_configure_args += --disable-write
util-linux_configure_args += --disable-login-stat-mail

# enable login 
util-linux_configure_args += --enable-login-utils

# otherwise chgrp fails on make install
util-linux_configure_args += --disable-use-tty-group

util-linux_image_include =					\
  echo bin/dmesg bin/login bin/more bin/mount bin/umount ;	\
  echo sbin/agetty sbin/hwclock sbin/swapon sbin/swapoff ;	\
  echo lib*/lib*.so*
