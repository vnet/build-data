# help2man cross compile breakage; avoid man sub directory
coreutils_make_args = SUBDIRS="lib src"

coreutils_install = $(PACKAGE_MAKE) $(coreutils_make_args) install

# garbage collect a bunch of stuff we are unlikely to want
coreutils_bin_excludes = \
  cksum comm csplit cut dir dircolors expand factor fmt fold groups \
  hostid install join last link logname mesg nl paste pathchk pinky pr ptx \
  runcon sha1sum sha224sum sha256sum sha384sum sha512sum shred shuf sort sum \
  tac timeout tr truncate tsort unexpand uniq unlink users vdir whoami

coreutils_image_exclude = bin/$(foreach f,$(coreutils_bin_excludes),bin/$(f))
