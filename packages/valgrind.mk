valgrind_CCASFLAGS += -I.. 

valgrind_configure_args = --prefix=/usr --libdir=/lib

valgrind_install_args = DESTDIR=$(PACKAGE_INSTALL_DIR)

# Reports shared libraries (and more) in given directory
valgrind_find_shared_libs_fn =  find $(1) -mindepth 2 -maxdepth 2 \
				! -regex $(arch_lib_dir)/valgrind/lib.*[.]a
 
valgrind_image_include = 				\
  for d in usr/bin ; do [[ -d $$d ]] && echo $$d; done ;\
  [[ -d $(arch_lib_dir) ]]				\
    && $(call valgrind_find_shared_libs_fn,$(arch_lib_dir))

