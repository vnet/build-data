# Modified Chord DHT currently under development by Andrei Agapi - aagapi@few.vu.nl. Depends on $(INSTALL_DIR)/db (BerkeleyDB) and $(INSTALL_DIR)/sfslite
# (sfslite 0.8.17), which were also ported and deployed. This source will soon be replaced by an enhanced version featuring further functionality. Current
# source is an older, stable version that was succesfully tested on ludd-1.

# Originally: had to do this: ./configure --with-sfs=$deploy_dir/sfslite-0.8.17_bin --with-db=$deploy_dir/db_bin [ --with-gmp=$deploy_dir/gmp ]  --prefix=$deploy_dir/dht_bin
# Now: If not overriden below, configure was modified s.t. with-sfs and with-db default to ppc7450 ebuild dirs (currently build-root/install-ppc7450
# ($)/sfslite and ($)/db respectively); also, gmp is looked up; but again, they are all overridden below.

dht_depend = db sfslite
$(call pkgPhaseDependMacro,dht)

dht_configure_args += --with-db

dht_configure_args += --with-sfs="$(BUILD_DIR)/sfslite"

dht_configure_args += --with-gmp=$(BUILD_DIR)/gmp

dht_configure_args += --enable-shared

##dht_configure_args += "sys_lib_dlsearch_path_spec='/lib/x86_64-linux-gnu /usr/lib/x86_64-linux-gnu '"

##dht_configure_args += "sys_lib_dlsearch_path_spec=' '"

##dht_configure_args += --with-pthreads=/

#dht_configure_args += "CXXDEBUG=-g -O0"
#dht_configure_args += "DEBUG=-g -O0"
