# Modified Chord DHT currently under development by Andrei Agapi - aagapi@few.vu.nl. Depends on $(INSTALL_DIR)/db (BerkeleyDB) and $(INSTALL_DIR)/sfslite
# (sfslite 0.8.17), which were also ported and deployed. This source will soon be replaced by an enhanced version featuring further functionality. Current
# source is an older, stable version that was succesfully tested on ludd-1.

# Originally: had to do this: ./configure --with-sfs=$deploy_dir/sfslite-0.8.17_bin --with-db=$deploy_dir/db_bin [ --with-gmp=$deploy_dir/gmp ]  --prefix=$deploy_dir/dht_bin
# Now: If not overriden below, configure was modified s.t. with-sfs and with-db default to ppc7450 ebuild dirs (currently build-root/install-ppc7450
# ($)/sfslite and ($)/db respectively); also, gmp is looked up; but again, they are all overridden below.
dht_depend = db sfslite nconfd nconfd-ulib
$(call pkgPhaseDependMacro,dht)

dht_top_srcdir = $(call find_source_fn,dht)

dht_CPPFLAGS =  -I$(elog_top_srcdir) -I$(BUILD_DIR)/gmp
dht_CPPFLAGS += -I$(BUILD_DIR)/db

dht_CPPFLAGS += -I$(nconfd_top_srcdir)/linux-$(nconfd_arch)/include
dht_CPPFLAGS += -I$(nconfd-lib_top_srcdir) -I$(nconfd-ulib_top_srcdir)

dht_LDFLAGS = -L$(BUILD_DIR)/elog -L$(BUILD_DIR)/nconfd-ulib \
	      -L$(BUILD_DIR)/qnanny -L$(BUILD_DIR)/svm -L$(BUILD_DIR)/clib


dht_configure_args += --with-db

dht_configure_args += --with-sfs="$(BUILD_DIR)/sfslite"

dht_configure_args += --with-gmp=$(BUILD_DIR)/gmp

dht_configure_args += --enable-shared

##dht_configure_args += "sys_lib_dlsearch_path_spec='/lib/x86_64-linux-gnu /usr/lib/x86_64-linux-gnu '"

##dht_configure_args += "sys_lib_dlsearch_path_spec=' '"

##dht_configure_args += --with-pthreads=/

#dht_configure_args += "CXXDEBUG=-g -O0"
#dht_configure_args += "DEBUG=-g -O0"

dht_configure_args += "CFLAGS=-g -O3"
dht_configure_args += "CXXFLAGS=-g -O3"

dht_make_args += NCONFD_ULIB=$(call find_source_fn,nconfd-ulib)
dht_make_args += CONFD_DIR=$(call package_install_dir_fn,nconfd)
dht_make_args += CONFD_ULIB_DIR=$(call package_install_dir_fn,nconfd-ulib)
dht_make_args += QNANNY_DIR=$(call package_install_dir_fn,qnanny)
dht_make_args += SVM_DIR=$(call package_install_dir_fn,svm)
dht_make_args += CLIB_DIR=$(call package_install_dir_fn,clib)

