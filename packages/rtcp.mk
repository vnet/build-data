rtcp_build_depend = libnfnetlink-install libnetfilter_queue-install \
			libpcap-install

rtcp_CPPFLAGS = $(call installed_includes_fn, libnfnetlink)
rtcp_CPPFLAGS += $(call installed_includes_fn, libnetfilter_queue)
rtcp_CPPFLAGS += $(call installed_includes_fn, libpcap)

rtcp_LDFLAGS = $(call installed_libs_fn, libnfnetlink)
rtcp_LDFLAGS += $(call installed_libs_fn, libnetfilter_queue)
rtcp_LDFLAGS += $(call installed_libs_fn, libpcap)

