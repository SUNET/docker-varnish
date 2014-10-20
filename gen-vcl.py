#!/usr/bin/env python

from jinja2 import Template
import yaml
import sys
from urlparse import urlparse

with open(sys.argv[1]) as config:
    data = yaml.load(config.read())
    data['uris'] = dict()
    for name,members in data['backends'].iteritems():
        for member in members:
            data['uris'][member] = urlparse(member)
    with open(sys.argv[2]) as template:
        t = Template(template.read())
        print t.render(**data)
