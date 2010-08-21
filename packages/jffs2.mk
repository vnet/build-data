jffs2_depend = zlib lzo
$(call pkgPhaseDependMacro,jffs2)

jffs2_CPPFLAGS = -I$(zlib_top_srcdir) -I$(lzo_top_srcdir)/include

jffs2_LDFLAGS = -L$(BUILD_DIR)/zlib/.libs -L$(BUILD_DIR)/lzo/src/.libs
