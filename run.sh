#!/bin/bash

mkdir -p server

# Build the Docker image
docker build -t ssh-server -f Dockerfile .

# Run the Docker container
docker run -d --name test-ssh-server \
    --hostname markymark-server \
    --network bridge \
    -p 2223:22 \
    --privileged \
    --gpus all \
    --mount type=bind,source="$(pwd)/server",target=/home/mark/mnt \
    --restart unless-stopped \
    ssh-server