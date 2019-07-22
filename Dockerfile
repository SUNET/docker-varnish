FROM debian:stable
MAINTAINER Leif Johansson <leifj@mnt.se>
RUN apt-get -q update
RUN apt-get -y upgrade
RUN apt-get install -y screen varnish xinetd python python-jinja2 python-yaml
ADD settings /etc/default/varnish
ADD monitor.sh /etc/varnish/monitor.sh
RUN chmod a+rx /etc/varnish/monitor.sh
ADD varnish-monitor /etc/xinetd.d/varnish-monitor
ADD gen-vcl.py /gen-vcl.py
RUN chmod a+rx /gen-vcl.py
ADD vcl.j2 /vcl.j2
ENV CONFIG ""
ADD start.sh /start.sh
RUN chmod a+rx /start.sh
ENTRYPOINT ["/start.sh"]
EXPOSE 80
