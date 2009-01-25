# does not like --build=local
#coreutils_configure_host_and_target = --host=$(TARGET)

# pretend we don't have perl to avoid building broken man pages which won't
# update when cross compiling.
coreutils_configure_env = PERL=""

# otherwise man pages get installed in / resulting in build failures
coreutils_install_args = mandir=$(PACKAGE_INSTALL_DIR)/man
