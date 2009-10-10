valgrind_CCASFLAGS += -I.. 

valgrind_configure_args = --prefix=/usr --libdir=/lib

valgrind_install_args = DESTDIR=$(PACKAGE_INSTALL_DIR)
