FROM ubuntu
MAINTAINER Leif Johansson <leifj@mnt.se>
RUN apt-get update
RUN apt-get install -y screen varnish xinetd python python-jinja2 python-yaml
ADD settings /etc/default/varnish
ADD monitor.sh /etc/varnish/monitor.sh
RUN chmod a+rx /etc/varnish/monitor.sh
ADD http-alt /etc/xinetd.d/http-alt
ADD gen-vcl.py /gen-vcl.py
RUN chmod a+rx /gen-vcl.py
ADD vcl.j2 /vcl.j2
ENV CONFIG config.yaml
CMD /gen-vcl.py $CONFIG vcl.j2 > /etc/varnish/default.vcl
ADD start.sh /start.sh
RUN chmod a+rx /start.sh
ENTRYPOINT ["/start.sh"]
