FROM raspbian/stretch

RUN apt-get update \
  && apt-get dist-upgrade -y \
  && apt-get install -y \
    python3 \
    python3-pip \
    apt-utils \
    apt-transport-https \
    cmake \
    git \
    liblog4cpp5-dev \
    libv4l-dev \
    curl jq vim \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /
RUN git clone https://github.com/mpromonet/v4l2rtspserver.git
WORKDIR /v4l2rtspserver
RUN cmake . && make
RUN make install

WORKDIR /
#CMD v4l2rtspserver -W 4096 -H 3040 -F 15 -P 8554 /dev/video0
#CMD v4l2rtspserver -W 2048 -H 1520 -F 15 -P 8554 /dev/video0
#CMD v4l2rtspserver -W 1024 -H 760 -F 15 -P 8554 /dev/video0
#CMD v4l2rtspserver -W 512 -H 380 -F 15 -P 8554 /dev/video0
CMD v4l2rtspserver -W 640 -H 480 -F 15 -P 8554 /dev/video0

