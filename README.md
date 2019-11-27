My Mopidy Setup
===============

This is the Docker image that I'm currently using to run [Mopidy](https://www.mopidy.com/) on a Raspberry Pi Zero with
[PhatDAC](https://shop.pimoroni.com/products/phat-dac).

It probably won't be exactly the setup you want, but feel free to create a fork for your own setup.

Build:

    docker build -t jjok/mopidy --build-arg BUILD_FROM=debian:stable-slim .
    docker build -t jjok/mopidy --build-arg BUILD_FROM=resin/rpi-raspbian:latest .

Run:

    docker run -it --rm --device /dev/snd --name mopidy -p 6600:6600 -p 6680:6680 -v ${HOME}/mopidy:/var/lib/mopidy jjok/mopidy

Run in background:

    docker run -d --restart=unless-stopped --device /dev/snd --name mopidy -p 6600:6600 -p 6680:6680 jjok/mopidy

View logs:

    docker logs mopidy

Execute any Mopidy command:

    docker exec mopidy mopidy <cmd>
    docker exec mopidy mopidy config
    docker exec mopidy mopidy deps


Raspberry PI Setup
------------------

1. Burn Raspbian to SD card (8GB+).
   A 2GB SD card will not be big enough for both Raspbian and the Docker image.
2. Put SD card in Raspberry Pi 2 (or 3).
   A Pi Zero does not have enough RAM to build the Docker image.
3. Install Docker CE.
   This is nice and easy these days. Just download as `.sh` file and run it.
4. Copy `Dockerfile` and `mopidy.conf` to the Pi.
5. Run `build` command (takes around 45 minutes on Pi 2)
6. Put SD card in Pi Zero
7. Run "Run in background" command
8. [Install PhatDAC soundcard](https://learn.pimoroni.com/tutorial/phat/raspberry-pi-phat-dac-install)
9. Reboot
