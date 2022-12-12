ARG BUILD_FROM
FROM $BUILD_FROM

ENV MOPIDY_VERSION='3.3.0-1'

SHELL ["/bin/bash", "-o", "pipefail", "-c"]
RUN apt-get update && apt-get -y --no-install-recommends install wget gnupg &&\
    mkdir -p /usr/local/share/keyrings/ &&\
    wget -qO - http://icecast.org/multimedia-obs.key | apt-key add - &&\
    wget -q -O /usr/local/share/keyrings/mopidy-archive-keyring.gpg \
    https://apt.mopidy.com/mopidy.gpg &&\
    sh -c "echo deb http://download.opensuse.org/repositories/multimedia:/xiph/Debian_10/ ./ >> /etc/apt/sources.list" &&\
	sed '1h;1d;$!H;$!d;G' /etc/apt/sources.list &&\
    wget -q -O /etc/apt/sources.list.d/mopidy.list "https://apt.mopidy.com/buster.list" &&\
    apt-get update &&\
    apt-get -y --no-install-recommends install \
        mopidy=${MOPIDY_VERSION} \
        icecast2=2.4.4-1 \
        jq=1.5+dfsg-2+b1 \
		python3-pip \
        python3-setuptools \
        python3-wheel \
        python-crypto \
        gstreamer1.0-alsa \
        gstreamer1.0-plugins-bad \
        sudo &&\
    apt-get -y autoremove && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN pip3 install youtube-dl certifi pafy Mopidy-Iris Mopidy-Local Mopidy-SoundCloud Mopidy-InternetArchive

# YouTube
# hadolint ignore=DL3013
RUN pip3 install https://github.com/natumbri/mopidy-youtube/archive/develop.zip

# Let mopidy run local scans
RUN echo "mopidy ALL=NOPASSWD: /usr/local/lib/python3.9/dist-packages/mopidy_iris/system.sh" >> /etc/sudoers

COPY mopidy.conf /share/mopidy/mopidy.conf
COPY icecast2.xml /etc/icecast2/icecast2.xml
COPY silence.mp3 /usr/share/icecast2/web/silence.mp3

COPY run.sh /
RUN chmod a+x /run.sh

EXPOSE 6600 6680
CMD [ "/run.sh" ]
