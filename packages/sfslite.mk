# This is a ported version of the last CVS snapshot of sfslite 0.8.17.
# The CVS version solves some bugs over latest stable release.
# sfslite was further developed but the dht we use is based on chord which uses
# the API of sfslite 0.8 and the API changed for later releases.
# This is not the actual CVS version, as this had limitations and some configure
#  errors, as well as issues when ported to the ebuild environment and to
# accomodate cross-compiling. Some changes made were:
#	- To be able to cross-compile e.g. for PowerPC, do not auto-generate
#         sources and headers at build time, since generating utilities need to
#         be compiled first and can't be run on native platform when
#         cross-compiling.
#         Use pregenerated sources and headers and do not clean them up.
#	  Such utilities are:
#		- the tame utility, used to generate sfslite callback calls
#		  from .T template files
#		- dftables,
#		  used to generate character tables into file async/chartables.c
#               - rpcc to generate sources from .x protocol files
#         This issue will be fixed, however.
#	- Generate configure script using autotools and fix some errors in
#         configure, e.g. prevent configure from failing on non-critical errors;
#	  also accomodate configure to 64 bit library location
#	- Port to newer kernel version (async/sysconf.h used struct cred,
#					not defined anymore in newer kernels)
#	- Port to gcc 4.3.3, which is more strict with template definitions and
#	  with enforcing parameter names in prototypes; for first problem used
#	  'fpermissive' flag, for second minor changes in headers;
#	  build will give warnings related to 'fpermissive' and other tighter
#	  enforcements by gcc 4.3. e.g. parantheses (Wno-parantheses),
#	  but these warnings are not fatal, therefore pls do not use -Werror
#	- sizeof issues to work with 64 bits

# Originally: had to do this: ./configure --with-sfsmisc --with-gmp=$deploy_dir/gmp-4.3.1_bin --with-mode=lite --prefix=$deploy_dir/sfslite-0.8.17_bin
# Now: If not overriden below, configure was modified s.t. with-sfsmisc is automatically added, with-mode is set to lite and with-gmp defaults to ppc7450 ebuild dir (currently build-root/install-ppc7450/gmp); but again, they are overridden below

sfslite_depend = elog
$(call pkgPhaseDependMacro,sfslite)
sfslite_configure_depend += gmp-install

#### jadfix for elog points ####

sfslite_CPPFLAGS = -I$(elog_top_srcdir) -I$(BUILD_DIR)/gmp #-DHAVE_GMP_CXX_OPS
sfslite_CPPFLAGS += -DELOGGING=1

sfslite_LDFLAGS = -L$(BUILD_DIR)/elog/.libs  -lpthread -lrt

sfslite_top_srcdir = $(call find_source_fn,sfslite)

sfslite_configure_args += --with-sfsmisc

sfslite_configure_args += --with-mode=lite

sfslite_configure_args += --with-gmp="$(BUILD_DIR)/gmp"

sfslite_configure_args += --enable-shared

sfslite_configure_args += --disable-rpcc-build

sfslite_configure_args += --with-x=no

sfslite_configure_args += --with-pthreads=$(INSTALL_DIR)/../tools/$(TARGET)

##sfslite_configure_args += "CXXDEBUG=-g -O0"
##sfslite_configure_args += "DEBUG=-g -O0"

sfslite_configure_args += "CFLAGS=-g -O3 $(sfslite_CPPFLAGS)"
sfslite_configure_args += "CXXFLAGS=-g -O3 $(sfslite_CPPFLAGS)"
sfslite_configure_args += "LDFLAGS=$(sfslite_LDFLAGS)"
