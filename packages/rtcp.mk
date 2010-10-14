rtcp_configure_depend=libnfnetlink-install libnetfilter_queue-install

rtcp_CPPFLAGS=$(call installed_includes_fn, libnfnetlink libnetfilter_queue)
rtcp_LDFLAGS=$(call installed_libs_fn, libnfnetlink libnetfilter_queue)

rtcp_image_include=  echo bin lib*
