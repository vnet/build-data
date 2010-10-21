cairo_configure_depend = freetype-install fontconfig-install pixman-install

cairo_configure_env = pixman_CFLAGS="-I$(call package_install_dir_fn,pixman)/include/pixman-1" pixman_LIBS="$(call installed_libs_fn,pixman)"
