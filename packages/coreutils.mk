# pretend we don't have perl to avoid building broken man pages which won't
# update when cross compiling.
coreutils_configure_env = PERL=""

# otherwise man pages get installed in / resulting in build failures
coreutils_install_args = mandir=$(PACKAGE_INSTALL_DIR)/man

# garbage collect a bunch of stuff we are unlikely to want
coreutils_bin_excludes = \
  cksum comm csplit cut dir dircolors expand factor fmt fold groups \
  hostid install join last link logname mesg nl paste pathchk pinky pr ptx \
  runcon sha1sum sha224sum sha256sum sha384sum sha512sum shred shuf sort sum sync \
  tac timeout tr truncate tsort unexpand uniq unlink users vdir whoami

coreutils_image_exclude = bin/$(foreach f,$(coreutils_bin_excludes),bin/$(f))

