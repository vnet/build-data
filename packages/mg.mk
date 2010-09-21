mg_depend = ncurses
$(call pkgPhaseDependMacro,mg)

mg_CPPFLAGS = -I$(BUILD_DIR)/ncurses/include -I$(ncurses_top_srcdir)/include

mg_LDFLAGS = -L$(BUILD_DIR)/ncurses/lib
