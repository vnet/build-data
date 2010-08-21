vnet_depend = vlib
$(call pkgPhaseDependMacro,vnet)

vnet_top_srcdir = $(call find_source_fn,vnet)

vnet_CPPFLAGS = -I$(vnet_top_srcdir)/../clib
vnet_CPPFLAGS += -I$(vnet_top_srcdir)/../vlib -I$(vnet_top_srcdir)/svm

vnet_LDFLAGS = -L$(BUILD_DIR)/vlib -L$(BUILD_DIR)/clib
