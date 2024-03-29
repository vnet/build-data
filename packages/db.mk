
# BerkeleyDB features a weird (albeit autotools-based) build system, whereby it has limited support for out of place builds. To build it, one has to change
# dir to the 'build_unix' subfolder of the actual distribution (or another subfolder at the same level in the source tree) and run:
# ../dist/configure --prefix=... to configure build in the 'build_unix' subfolder. The Makefile there then needs sources relative to the root source dir (..)
#
# This setup can't easily support building in separate folders for various cross-compilations targets ($PACKAGE_BUILD_DIR as used in ebuild, e.g.
# build-ppc7450, build-native etc), and building in a separate tree as in ebuild, since sources in many "brother folders" contained in parent folder of the
# build folder within source tree are needed. Initially I had quickfixed this by having e.g. build-ppc7450/db simply be a symlink to
# build-root/../db/build_unix (in the source section of the ebuild tree) and tweaking configure, but this yields problems as we use many
# cross-compilation targets, as objects will actually reside in the source folder build-root/../db and are not correct between targets.
#
# Current solution below is to replace configure and have it copy the source folder build-root/../db in a dummy folder (in build section of ebuild), brother
# to $PACKAGE_BUILD_DIR, called .db_copy and having $PACKAGE_BUILD_DIR be a symlink to .db_copy/build_unix. This causes builds to be separate for various
# compilation targets and not interfere and also keeps source tree clean.
# Clean target is also overridden to simply delete .db_copy (the source copy folder) and the symlink, which is functionally correct because, as advised on
# wiki page, make db-cleanup should "result in reconfiguration and recompilation of the specific platform image", which is achieved by re-copying the sources
# to the dummy folder.
#
# Andrei Agapi, September 2009.
 
db_top_srcdir = $(call find_source_fn,db)

host_particle=$(if $(ARCH:native=),--build=$(NATIVE_ARCH)-linux-gnu --host=$(TARGET),)

PARENT_ABS_PATH=$(shell dirname $(PACKAGE_BUILD_DIR))

db_configure =								\
   cd $(db_top_srcdir)/dist ;						\
   if [ ! -f configure ] ; then						\
      libtoolize ; aclocal -I aclocal ; autoconf ; autoheader ;		\
   fi ;									\
   echo "Building in $(PACKAGE_BUILD_DIR), "	;			\
    echo " host_particle=$(host_particle) ..." ;			\
   echo "cd $(PACKAGE_BUILD_DIR)" ;					\
   cd $(PACKAGE_BUILD_DIR) ;						\
   echo  "../dist/configure  --enable-o_direct " ;			\
   echo  " --libdir=$(prefix)/$(arch_lib_dir)" ;			\
   echo  " --prefix=$(prefix) "	;					\
   echo  " $(host_particle)" ;						\
   $(db_top_srcdir)/dist/configure --enable-o_direct			\
      --libdir=$(prefix)/$(arch_lib_dir)	--prefix=$(prefix)	\
      $(host_particle)
