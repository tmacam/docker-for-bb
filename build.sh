#!/bin/bash

# TODO (this should be a Makerfile)

set -e

# http_proxy=http://$(ipconfig getifaddr en0):3142/

docker build --build-arg http_proxy=http://$(ipconfig getifaddr en0):3142/ -t tmacam/bb:base --file Dockerfile.base .

docker run -it --name=tmacam-bb-tmp --env TERM=linux tmacam/bb:base  /tmp/diagbb-1.0.64.run
docker commit tmacam-bb-tmp tmacam/bb:run
docker build -t tmacam/bb:firefox --file Dockerfile.run .

# docker run -e DISPLAY=$(ipconfig getifaddr en0):0 -v /tmp/.X11-unix:/tmp/.X11-unix -it tmacam/bb:firefox
