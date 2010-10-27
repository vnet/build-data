inetutils_configure_args = --localstatedir=/var

# 1.8 wont cross compile without this
inetutils_configure_args += --with-path-procnet-dev=/proc/net/dev

# garbage collect a bunch of stuff we are unlikely to want
inetutils_image_exclude =			\
  libexec/ftpd					\
  libexec/rexecd				\
  libexec/rlogind				\
  libexec/rshd					\
  libexec/talkd					\
  libexec/uucpd					\
  bin/rcp					\
  bin/rlogin					\
  bin/rsh					\
  bin/whois

# we use ifconfig from net-tools
inetutils_image_exclude += bin/ifconfig

# we use xinetd so nuke inetd
inetutils_image_exclude += libexec/inetd

