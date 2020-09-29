ARG BUILD_FROM=debian:buster-slim

FROM $BUILD_FROM

RUN apt-get update \
 && apt-get install -y wget \
                       gnupg2 \
 && wget -q -O - https://apt.mopidy.com/mopidy.gpg | apt-key add - \
 && wget -q -O /etc/apt/sources.list.d/mopidy.list https://apt.mopidy.com/buster.list

RUN apt-get update \
 && apt-get install -y libffi-dev \
                       libxml2-dev \
                       libxslt1-dev \
                       zlib1g-dev \
                       build-essential \
                       gstreamer1.0-alsa \
                       gstreamer1.0-plugins-bad \
                       gstreamer1.0-plugins-good \
                       gstreamer1.0-plugins-ugly \
                       python3-dbus \
                       python3-dev \
                       python3-gst-1.0 \
                       python3-lxml \
                       python3-pip \
                       python3-setuptools \
                       python3-wheel \
                       libasound2-dev \
                       libspotify-dev \
                       dleyna-server \
 && rm -rf /var/lib/apt/lists/*

# Add git to get some Mopidy stuff straight from Github
RUN apt-get update \
 && apt-get install -y git \
 && rm -rf /var/lib/apt/lists/*

COPY requirements.txt requirements.txt

RUN pip3 install -r requirements.txt \
 && rm -rf ~/.cache/pip

RUN update-ca-certificates --fresh

COPY mopidy.conf /root/.config/mopidy/

VOLUME ["/root/.cache/mopidy", "/root/.local/share/mopidy"]

ENV TZ=Europe/London

EXPOSE 6600 6680

ENTRYPOINT ["mopidy"]
