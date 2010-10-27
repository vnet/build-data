#
# bootmisc.sh	Miscellaneous things to be done during bootup.
#
# Version:	@(#)bootmisc.sh  2.83  02-Oct-2001  miquels@cistron.nl
#

. /etc/rc.d/rc.defaults
. /etc/rc.d/rc.functions

#
# Put a nologin file in /etc to prevent people from logging in before
# system startup is complete.
#
if [ "$DELAYLOGIN" = yes ]
then
  echo "System bootup in progress - please wait" > /etc/nologin
  cp /etc/nologin /etc/nologin.boot
fi

#
# Wipe /tmp (and don't erase `lost+found', `quota.user' or `quota.group')!
# Note that files _in_ lost+found _are_ deleted.
#
[ "$VERBOSE" != no ] && echo -n "Cleaning: /tmp "
rm -rf /tmp/* /tmp/.??*

#
# Clean up any stale locks.
#
[ "$VERBOSE" != no ] && echo -n "/var/lock "
( cd /var/lock && find . -type f ! -newer /etc/mtab -exec rm -f -- {} \; )
#
# Clean up /var/run and create /var/run/utmp so that we can login.
#
[ "$VERBOSE" != no ] && echo -n "/var/run"
( cd /var/run && \
	find . ! -type d ! -name utmp ! -name innd.pid \
	! -newer /etc/mtab -exec rm -f -- {} \; )
: > /var/run/utmp
if grep -q ^utmp: /etc/group
then
	chmod 664 /var/run/utmp
	chgrp utmp /var/run/utmp
fi
[ "$VERBOSE" != no ] && echo "."

#
# Update /etc/motd.
#
if [ "$EDITMOTD" != no ]
then
	uname -a > /etc/motd.tmp
	sed 1d /etc/motd >> /etc/motd.tmp
	mv /etc/motd.tmp /etc/motd
fi

#
# Save kernel messages in /var/log/dmesg
#
dmesg -s 65536 > /var/log/dmesg

# Sets hostname based on /etc/rc.d/hostname
HOSTNAME_FILE=/etc/rc.d/hostname
if [ ! -f $HOSTNAME_FILE ]; then
  # Start rc.initconfig here!
  prompt_text HOSTNAME 'test.cisco.com' "Enter hostname"	
  echo $HOSTNAME >> $HOSTNAME_FILE;
fi

hostname `cat $HOSTNAME_FILE`

: exit 0

