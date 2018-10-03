
Build:

    docker build -t jjok/mopidy .
    docker save -o mopidy.tar jjok/mopidy

Run:

    docker load < mopidy.tar
    docker run -it --rm --device /dev/snd -p 6680:6680 jjok/mopidy

Run on startup:

    docker run -d --rm --device /dev/snd --name mopidy -p 6680:6680 jjok/mopidy
