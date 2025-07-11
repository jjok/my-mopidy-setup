My Mopidy Setup
===============

These is the Docker images that I'm currently using to run [Mopidy](https://www.mopidy.com/) and [Snapserver](https://github.com/badaix/snapcast) on a Raspberry Pi 3a, and [Snapclient](https://github.com/badaix/snapcast) with a
[PhatDAC](https://shop.pimoroni.com/products/phat-dac) or IQAudio Pi-DACZero on a Raspberry Pi Zero.

It probably won't be exactly the setup you want, but feel free to create a fork for your own setup.

The Mopidy version and all extensions to be installed are defined in `requirements.txt`.

I have music files in `~/music` that I mount into the container.


Build
-----

Build on PC

    docker compose build mopidy snapserver --build-arg BUILD_FROM=docker.io/debian:bookworm-slim --build-arg ARCH=amd64

Build on Raspberry Pi (takes about 40 minutes on Pi 3)

    docker compose build mopidy snapserver

Run Mopidy and Snapserver
-------------------------

    docker compose up mopidy snapserver -d

Run Snapclient
--------------

    docker compose up snapclient -d

View logs:

    docker logs -f mopidy

Execute any Mopidy command:

    docker exec mopidy mopidy <cmd>
    docker exec mopidy mopidy config
    docker exec mopidy mopidy deps


Raspberry PI Setup
------------------

### Mopidy and Snapcast

1. Burn Raspberry PI OS to SD card (16GB+). Put SD card in Raspberry Pi.
3. Copy files to the Pi. `make upload-snapserver`
  * `snapserver`
  * `docker-compose.yml`
  * `Dockerfile`
  * `Makefile`
  * `mopidy.conf`
  * `requirements.txt`
3. `ssh` onto Pi 
4. Install [Docker CE](https://docs.docker.com/engine/install/ubuntu/#install-using-the-convenience-script).
5. Run the `build` command
6. Mount music from USB (see below)
7. Run container `docker compose up mopidy snapserver -d`
8. Reboot
9. Scan for music `docker exec mopidy mopidy local scan`

### Snapclient

1. Install Raspberry Pi OS
2. Copy files to the Pi.
   * `make client=office upload`
   * `make client=kitchen upload`
3. `ssh` onto Pi
3. Install Docker CE
4. Run `docker compose build snapclient`
5. Install soundcard (see below)
6. Reboot
7. Run container `docker compose up snapclient -d`

Install PhatDAC
---------------

https://learn.pimoroni.com/tutorial/phat/raspberry-pi-phat-dac-install

Their install script doesn't work for Raspberry Pi OS Bookworm. I managed to get it working.

Edit `/boot/firmware/config.txt`.

Remove this line:

    dtparam=audio=on

Add this line:

    dtoverlay=hifiberry-dac

Maybe enable I2C or something in `raspi-config`?


Install IQaudIO Pi-DACZero
--------------------------

https://github.com/iqaudio/UserDocs/blob/master/userguide.pdf

Edit `/boot/firmware/config.txt`.

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
