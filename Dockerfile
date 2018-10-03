FROM debian:stable-slim
 
RUN apt-get update && apt-get install -y \
    wget \
    gnupg2 \
 && wget -q -O - https://apt.mopidy.com/mopidy.gpg | apt-key add - \
 && wget -q -O /etc/apt/sources.list.d/mopidy.list https://apt.mopidy.com/stretch.list \
 && apt-get update && apt-get install -y \
    libffi-dev \
    zlib1g-dev \
    libxml2-dev \
    libxslt1-dev \
    python-dev \
    mopidy \
    mopidy-scrobbler \
    mopidy-spotify \
    mopidy-podcast \
    python-pip \
 && rm -rf /var/lib/apt/lists/* \
 && pip install mopidy-gmusic \
                mopidy-musicbox-webclient \
 && pip install pyasn1 --upgrade \
 && rm -rf ~/.cache/pip

COPY mopidy.conf /root/.config/mopidy/

EXPOSE 6600 6680 5555/udp

CMD mopidy
