DATE := $(shell date +"%Y-%m-%d")
IMAGE := jjok/mopidy


default: build-pi tag down run-bg save

upload-snapserver:
	rsync -ahvP --recursive --files-from=snapserver-build-files.txt ./ jonathan@raspberrypi.local:mopidy-build/

upload-snapclient:
	rsync -ahvP --recursive --files-from=snapclient-build-files.txt ./ jonathan@snapclient.local:snapclient-build/

build-pc:
	docker build --pull -t $(IMAGE):$(DATE) --build-arg ARCH=amd64 --build-arg BUILD_FROM=debian:stable-slim .

build-pi:
	docker build --pull -t $(IMAGE):$(DATE) --build-arg ARCH=armhf --build-arg BUILD_FROM=balenalib/raspberry-pi:latest .

tag:
	docker tag $(IMAGE):$(DATE) $(IMAGE):latest

save:
	docker save $(IMAGE):$(DATE) $(IMAGE):latest > jjok_mopidy_$(shell date +"%Y_%m_%d").tar

down:
	docker stop mopidy
	docker rm mopidy
	docker image prune -f

run-fg:
	docker run --name mopidy --device /dev/snd -p 6600:6600 -p 6680:6680 -v /home/$(USER)/music:/root/music --rm -it $(IMAGE):latest

run-bg:
	docker run --name mopidy --device /dev/snd --net host -v /home/$(USER)/music:/root/music --restart=unless-stopped -d $(IMAGE):latest

sync-music:
	rsync -ahvP --recursive --files-from=music.txt /media/jonathan/77B9-F955/music/ jonathan@office-musicbox.local:music/
