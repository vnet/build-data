binutils_configure_host_and_target = --target=$(TARGET)

binutils_configure_args = --disable-nls --enable-shared
binutils_configure_args += --with-sysroot=$(TARGET_TOOL_INSTALL_DIR)

