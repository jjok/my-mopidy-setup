DATE := $(shell date +"%Y-%m-%d")

build-pc:
	docker build --pull -t jjok/mopidy:$(DATE) --build-arg BUILD_FROM=debian:stable-slim .

build-pi:
	docker build --pull -t jjok/mopidy:$(DATE) --build-arg BUILD_FROM=balenalib/rpi-raspbian:latest .

tag:
	docker tag jjok/mopidy:$(DATE) jjok/mopidy:latest

run-fg:
	docker run --name mopidy --device /dev/snd -p 6600:6600 -p 6680:6680 -v /home/pi/music:/root/music --rm -it jjok/mopidy:latest

run-bg:
	docker run --name mopidy --device /dev/snd -p 6600:6600 -p 6680:6680 -v /home/pi/music:/root/music --restart=unless-stopped -d jjok/mopidy:latest
