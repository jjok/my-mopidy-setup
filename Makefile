DATE := $(shell date +"%Y-%m-%d")

build-pc:
	docker build --pull -t jjok/mopidy:$(DATE) --build-arg BUILD_FROM=debian:stable-slim .

build-pi:
	docker build --pull -t jjok/mopidy:$(DATE) --build-arg BUILD_FROM=balenalib/rpi-raspbian:latest .

tag:
	docker tag jjok/mopidy:$(DATE) jjok/mopidy:latest
