My Mopidy Setup
===============

This is the Docker image that I'm currently using to run [Mopidy](https://www.mopidy.com/) on a Raspberry Pi Zero with
[PhatDAC](https://shop.pimoroni.com/products/phat-dac).

It probably won't be exactly the setup you want, but feel free to create a fork for your own setup.

Build:

    docker build -t jjok/mopidy .
    docker build -t jjok/mopidy -f Dockerfile.pi .

Run:

    docker run -it --rm --device /dev/snd --name mopidy -p 6680:6680 jjok/mopidy

Run in background:

    docker run -d --rm --device /dev/snd --name mopidy -p 6680:6680 jjok/mopidy

View logs:

    docker logs mopidy

Execute any Mopidy command:

    docker exec mopidy mopidy <cmd>
    docker exec mopidy mopidy config
    docker exec mopidy mopidy deps


Raspberry PI Setup
------------------

1. Burn Raspbian to SD card (8GB+)
2. Put SD card in Raspberry Pi 2 (or 3)
3. Install Docker CE
4. Get `Dockerfile` and `mopidy.conf`
5. Run `build` command (takes around 45 minutes)
6. Put SD card in Pi Zero
7. Edit `/etc/rc.local` and add "Run in background" command
8. Install soundcard (PhatDAC)
9. Reboot
