VENDOR ?= bmansfield
APPNAME ?= signal-desktop
TAG ?= latest
DOCKER_IMG ?= $(VENDOR)/$(APPNAME):$(TAG)

all: docker_build

default: docker_build

build: docker_build_clean

run: run_ctnr

docker_build:
	docker build \
		-t $(DOCKER_IMG) .

docker_build_clean:
	docker build \
		--no-cache \
		--force-rm \
		-t $(DOCKER_IMG) .

run_ctnr:
	IP=$(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}') ;
	xhost + ;
	xhost + $IP ;
	export DISPLAY=$IP ;
	docker run \
		-it \
		--volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
		--volume="$HOME/Downloads:/root/Downloads:rw" \
		-e DISPLAY=$IP:0 \
		--name signal \
		$(DOCKER_IMG)

.PHONY: build run
