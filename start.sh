#!/bin/sh

service xinetd start

/gen-vcl.py vcl.j2 $CONFIG > /etc/varnish/default.vcl
. /etc/default/varnish
varnishd -F $DAEMON_OPTS
