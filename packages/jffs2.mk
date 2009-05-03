jffs2_configure_depend = zlib-install lzo-install

jffs2_CPPFLAGS += $(call installed_includes_fn, zlib lzo)
jffs2_LDFLAGS += $(call installed_libs_fn, zlib lzo)
