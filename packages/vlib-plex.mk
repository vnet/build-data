vlib-plex_configure_depend = clib-install vlib-install

vlib-plex_CPPFLAGS = $(call installed_includes_fn, clib vlib)
vlib-plex_LDFLAGS = $(call installed_libs_fn, clib vlib)
