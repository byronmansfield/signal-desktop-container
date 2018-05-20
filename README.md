# Signal Desktop Messenger Container

This is a project containerizes Signal Desktop Messenger. Because what's better than a secure messenger? A portable ephemeral secure messenger that leaves no trace behind.

## Table of content

- [Requirements](#requirements)
- [Get the image](#get-the-image)
  * [Build yourself](#build-yourself)
  * [Pull from dockerhub](#pull-from-dockerhub)
- [Run container](#run-container)
  * [Make](#make)
  * [Manually](#manually)
- [Extra](#extra)

## Requirements

 - X Server
 - Docker
 - GNU make (Optional, only needed for building project if you want to use Makefile to build)

## Get the image

You can obtain the image by one of two methods.

### Build yourself

If you are building it yourself you will have to clone the project first

```bash
git clone byronmansfield/signal-desktop-container.git
cd signal-desktop-container
```

Then you can use the `Makefile` to build it if you have GNU make installed. The default task is the build task

```bash
make
```

Otherwise you can just manually build it

```bash
docker build -t signal-desktop .
```

### Pull from dockerhub

You can pull the pre-built image from dockerhub

```bash
docker pull bmansfield/signal-desktop:latest
```

## Run container

The `Makefile` has a run task, or you can manually run it. But there is a little prep-work you will need to do before you can just run it manually. The make task should take care of this for us though.

### Make

```bash
make run
```

### Manually

```bash
IP=$(ifconfig en0 | grep inet | awk '$1=="inet" {print $2}')
xhost +
xhost + $IP
export DISPLAY=$IP
docker run -it --volume="$HOME/Downloads:/root/Downloads:rw" --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" -e DISPLAY=$IP:0 --name signal bmansfield/signal-desktop:latest
```

And it should automagically open up a new instance of Signal Desktop asking you to link the device. Link and enjoy secure private messaging.

## Extra

Alias for greater convenience

```bash
alias signalctnr='IP=$(ifconfig en0 | grep '"'"'inet '"'"' | awk '"'$1==inet "'{print $2}'"'"'); export DISPLAY=$IP; xhost +; xhost + $IP; docker run -it --volume="$HOME/Downloads:/root/Downloads:rw" --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" -e DISPLAY=$IP:0 --name signal bmansfield/signal-desktop:latest'
```

