all: build push
update:
	docker build -t varnish .
	docker tag -f varnish docker.sunet.se/varnish
build:
	docker build --no-cache=true -t varnish .
	docker tag -f varnish docker.sunet.se/varnish
push:
	docker push docker.sunet.se/varnish
