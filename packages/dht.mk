# Modified Chord DHT currently under development by Andrei Agapi - aagapi@few.vu.nl. Depends on $(INSTALL_DIR)/db (BerkeleyDB) and $(INSTALL_DIR)/sfslite
# (sfslite 0.8.17), which were also ported and deployed. This source will soon be replaced by an enhanced version featuring further functionality. Current
# source is an older, stable version that was succesfully tested on ludd-1.

# Originally: had to do this: ./configure --with-sfs=$deploy_dir/sfslite-0.8.17_bin --with-db=$deploy_dir/db_bin [ --with-gmp=$deploy_dir/gmp ]  --prefix=$deploy_dir/dht_bin
# Now: If not overriden below, configure was modified s.t. with-sfs and with-db default to ppc7450 ebuild dirs (currently build-root/install-ppc7450
# ($)/sfslite and ($)/db respectively); also, gmp is looked up; but again, they are all overridden below.

#dht_configure_depend = db-install sfslite-install gmp-install elog-install
dht_configure_depend = db-install sfslite-install gmp-install

#dht_CPPFLAGS = $(call installed_includes_fn, elog)

#dht_LDFLAGS = $(call installed_libs_fn, elog)

dht_configure_args += --with-db=$(INSTALL_DIR)/db

dht_configure_args += --with-sfs=$(INSTALL_DIR)/sfslite

dht_configure_args += --with-gmp=$(INSTALL_DIR)/gmp

dht_configure_args += --enable-shared

