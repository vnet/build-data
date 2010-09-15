spp_depend = clib
$(call pkgPhaseDependMacro,spp)

spp_CPPFLAGS = -I$(clib_top_srcdir)

spp_LDFLAGS = -L$(BUILD_DIR)/clib/.libs
