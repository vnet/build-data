# garbage collect a bunch of stuff we are unlikely to want
inetutils_bin_excludes =			\
  libexec/ftpd					\
  libexec/rexecd				\
  libexec/rlogind				\
  libexec/rshd					\
  libexec/talkd					\
  libexec/uucpd					\
  bin/ping6					\
  bin/rcp					\
  bin/rlogin					\
  bin/rsh					\
  bin/whois

# we use ifconfig from net-tools
inetutils_bin_excludes += bin/ifconfig

inetutils_image_exclude = bin/$(foreach f,$(inetutils_bin_excludes),$(f))
