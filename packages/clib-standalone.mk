# same source, potentially different configure args
clib-standalone_source = clib

# only need standalone version of clib
clib-standalone_configure_args = --with-standalone
clib-standalone_configure_args += --without-linux-kernel --without-unix 

# newer gcc version emit stack protector code by default
clib-standalone_standalone_cflags += -fno-stack-protector

clib-standalone_standalone_cflags_x86_64 += -mcmodel=kernel

clib-standalone_standalone_cflags += $(clib-standalone_standalone_cflags_$(ARCH))

clib-standalone_configure_args += --with-standalone-cflags="$(clib-standalone_standalone_cflags)"

