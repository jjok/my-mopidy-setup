ARG BUILD_FROM
ARG ARCH

FROM $BUILD_FROM
ARG ARCH

RUN apt-get update \
 && apt-get install -y wget \
                       gstreamer1.0-alsa \
                       gstreamer1.0-plugins-good \
                       gstreamer1.0-plugins-ugly \
                       gstreamer1.0-plugins-bad \
                       python3-gst-1.0 \
                       python3-lxml \
                       python3-pip \
                       python3-setuptools \
                       python3-wheel \
                       libasound2-dev \
 && rm -rf /var/lib/apt/lists/*

RUN wget -O gst-plugin-spotify.deb https://github.com/kingosticks/gst-plugins-rs-build/releases/download/gst-plugin-spotify_0.12.2-1/gst-plugin-spotify_0.12.2-1_${ARCH}.deb \
 && dpkg -i gst-plugin-spotify.deb

# Add git to get some Mopidy stuff straight from Github
#RUN apt-get update \
# && apt-get install -y git \
# && rm -rf /var/lib/apt/lists/*

COPY requirements.txt requirements.txt

RUN pip3 install --break-system-packages -r requirements.txt \
 && rm -rf ~/.cache/pip

RUN update-ca-certificates --fresh

COPY mopidy.conf /root/.config/mopidy/

RUN mkdir /root/music

VOLUME ["/root/.cache/mopidy", "/root/.local/share/mopidy", "/root/music"]

ENV TZ=Europe/London

EXPOSE 6600 6680

ENTRYPOINT ["mopidy"]
