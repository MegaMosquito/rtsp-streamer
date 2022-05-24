# A simple service that streams video from a camera attached to the host

DOCKERHUB_ID:=ibmosquito
NAME:="rtsp-streamer"
VERSION:="1.0.0"

# You will need to change this in the Dockerfile too if not using /dev/video0
VIDEO_DEVICE:=/dev/video0

default: build run

build:
	docker build -t $(DOCKERHUB_ID)/$(NAME):$(VERSION) .

dev: stop build
	docker run -it -v `pwd`:/outside \
          --name ${NAME} \
          -p 8554:8554 \
          --device $(VIDEO_DEVICE):$(VIDEO_DEVICE) \
          $(DOCKERHUB_ID)/$(NAME):$(VERSION) /bin/bash

run: stop
	docker run -d \
          --name ${NAME} \
          --restart unless-stopped \
          -p 8554:8554 \
          --device $(VIDEO_DEVICE):$(VIDEO_DEVICE) \
          $(DOCKERHUB_ID)/$(NAME):$(VERSION)

test:
	echo "Use VLC to test this container."

push:
	docker push $(DOCKERHUB_ID)/$(NAME):$(VERSION) 

stop:
	@docker rm -f ${NAME} >/dev/null 2>&1 || :

clean:
	@docker rmi -f $(DOCKERHUB_ID)/$(NAME):$(VERSION) >/dev/null 2>&1 || :

.PHONY: build dev run push test stop clean

