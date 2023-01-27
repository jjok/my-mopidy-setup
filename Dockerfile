ARG BUILD_FROM=debian:buster-slim

FROM $BUILD_FROM

RUN apt-get update \
 && apt-get install -y gstreamer1.0-alsa \
                       gstreamer1.0-plugins-good \
                       python3-gst-1.0 \
                       python3-lxml \
                       python3-pip \
                       python3-setuptools \
                       python3-wheel \
                       libasound2-dev \
 && rm -rf /var/lib/apt/lists/*

# Add git to get some Mopidy stuff straight from Github
#RUN apt-get update \
# && apt-get install -y git \
# && rm -rf /var/lib/apt/lists/*

COPY requirements.txt requirements.txt

RUN pip3 install -r requirements.txt \
 && rm -rf ~/.cache/pip

RUN update-ca-certificates --fresh

COPY mopidy.conf /root/.config/mopidy/

RUN mkdir /root/music

VOLUME ["/root/.cache/mopidy", "/root/.local/share/mopidy", "/root/music"]

ENV TZ=Europe/London

EXPOSE 6600 6680

ENTRYPOINT ["mopidy"]
