#
# Regular cron jobs for the lair package
#
0 4	* * *	root	[ -x /usr/bin/lair_maintenance ] && /usr/bin/lair_maintenance
