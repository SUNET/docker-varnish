#!/bin/sh

service xinetd start

. /etc/default/varnish
varnishd -F $DAEMON_OPTS
