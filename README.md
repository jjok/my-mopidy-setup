My Mopidy Setup
===============

This is the Docker image that I'm currently using to run [Mopidy](https://www.mopidy.com/) on a Raspberry Pi Zero with
[PhatDAC](https://shop.pimoroni.com/products/phat-dac) and a Pi 2 with an IQAudio Pi-DACZero.

It probably won't be exactly the setup you want, but feel free to create a fork for your own setup.

The Mopidy version and all extensions to be installed are defined in `requirements.txt`.

I have music files in `~/music` that I mount into the container.


Build
-----

Build on PC

    docker build --pull -t jjok/mopidy --build-arg BUILD_FROM=debian:stable-slim .

Build on Raspberry Pi

    docker build --pull -t jjok/mopidy --build-arg BUILD_FROM=balenalib/raspberry-pi:latest .

Run
---

    docker compose up -d

View logs:

    docker logs -f mopidy

Execute any Mopidy command:

    docker exec mopidy mopidy <cmd>
    docker exec mopidy mopidy config
    docker exec mopidy mopidy deps


Raspberry PI Setup
------------------

1. Burn Raspberry PI OS to SD card (8GB+). Put SD card in Raspberry Pi.
2. Install [Docker CE](https://docs.docker.com/engine/install/ubuntu/#install-using-the-convenience-script).
3. Copy files to the Pi.
  * `.dockerignore`
  * `docker-compose.yml`
  * `Dockerfile`
  * `Makefile`
  * `mopidy.conf`
  * `requirements.txt`
4. Run `build` command (takes around 30 minutes on Pi Zero)
5. Install soundcard (see below).
6. Run container
7. Reboot


Install PhatDAC
---------------

https://learn.pimoroni.com/tutorial/phat/raspberry-pi-phat-dac-install

Edit `/boot/config.txt`.

Remove this line:

    dtparam=audio=on

Add this line:

    dtoverlay=hifiberry-dac

You might need to do some other stuff too. I haven't tried this manually yet.
    

Install IQaudIO Pi-DACZero
--------------------------

https://github.com/iqaudio/UserDocs/blob/master/userguide.pdf

Edit `/boot/config.txt`.

Remove this line:

    dtparam=audio=on

Add this line:

    dtoverlay=iqaudio-dacplus


Mount music from USB
--------------------

    mkdir ~/usb
    mkdir ~/music

Add these lines to `/etc/fstab`.

    /dev/sda1                  /home/jonathan/usb    vfat   defaults         0   0
    /home/jonathan/usb/music   /home/jonathan/music  none   defaults,rbind   0   0
