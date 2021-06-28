My Mopidy Setup
===============

This is the Docker image that I'm currently using to run [Mopidy](https://www.mopidy.com/) on a Raspberry Pi Zero with
[PhatDAC](https://shop.pimoroni.com/products/phat-dac).

It probably won't be exactly the setup you want, but feel free to create a fork for your own setup.

Build on PC

    docker build --pull -t jjok/mopidy --build-arg BUILD_FROM=debian:stable-slim .

Build on Raspberry Pi

    docker build --pull -t jjok/mopidy --build-arg BUILD_FROM=balenalib/rpi-raspbian:latest .

Run in foreground:

    docker run --rm \
               --name mopidy \
               --device /dev/snd \
               --net=host \
               -it \
               jjok/mopidy

Run in background:

    docker run --restart=unless-stopped \
               --name mopidy \
               --device /dev/snd \
               --net=host \
               -d \
               jjok/mopidy

View logs:

    docker logs -f mopidy

Execute any Mopidy command:

    docker exec mopidy mopidy <cmd>
    docker exec mopidy mopidy config
    docker exec mopidy mopidy deps


Mount music from Samba share on network

    sudo apt install samba samba-common-bin smbclient cifs-utils

    echo "//192.168.1.1/share  /home/pi/music  cifs  guest,vers=1.0  0  0" | sudo tee -a /etc/fstab

Raspberry PI Setup
------------------

1. Burn Raspberry PI OS to SD card (8GB+).
   A 2GB SD card will not be big enough for both Raspbian and the Docker image.
2. Put SD card in Raspberry Pi 2.
   A Pi Zero does not have enough RAM to build the Docker image.
3. Install Docker CE. `sudo apt install docker-ce`
4. Copy `Dockerfile`, `requirements.txt` and `mopidy.conf` to the Pi.
5. Run `build` command (takes around 45 minutes on Pi 2)
6. Put SD card in Pi Zero
7. Run "Run in background" command
8. [Install PhatDAC soundcard](https://learn.pimoroni.com/tutorial/phat/raspberry-pi-phat-dac-install)
9. Reboot
