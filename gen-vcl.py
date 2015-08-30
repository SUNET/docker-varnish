#!/usr/bin/env python

from jinja2 import Template
import yaml
import sys
import os
from urlparse import urlparse

def _render(d):
    with open(sys.argv[1]) as template:
        t = Template(template.read())
        print t.render(**d)


data = None
if len(sys.argv) == 3:
     with open(sys.argv[2]) as config:
         data = yaml.load(config.read())
elif 'BACKEND_PORT' in os.environ:
    backend_uri = os.environ['BACKEND_PORT']
    backend_uri = backend_uri.replace("tcp://","http://")
    if not backend_uri.endswith("/"):
        backend_uri = "%s/" % backend_uri
    public_name = 'localhost'
    data = dict(domain='localdomain',backends=dict(backend=[backend_uri]),vhosts=dict())
else:
    print "No linked applications and no config" 
    sys.exit(-1)

data['uris'] = dict()
for name,members in data['backends'].iteritems():
    for member in members:
        data['uris'][member] = urlparse(member)

_render(data)
