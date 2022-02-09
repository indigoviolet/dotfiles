#!/bin/bash

set -eux

# # https://docs.docker.com/engine/install/ubuntu/#install-using-the-convenience-script
# curl https://get.docker.com | sh && sudo systemctl --now enable docker

# # https://docs.docker.com/engine/install/linux-postinstall/
# sudo groupadd -f docker
# sudo usermod -aG docker $USER
docker run hello-world

# ------------- #
# nvidia-docker #
# ------------- #

# https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html#pre-requisites
# We are using the 20.04 install instead of 20.10: https://github.com/NVIDIA/nvidia-docker/issues/1407

distribution=$(
    . /etc/os-release
    echo ${ID}20.04
) &&
    curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add - &&
    curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list

sudo apt-get update && sudo apt-get install --no-install-recommends -y nvidia-docker2
sudo systemctl restart docker

pipx install docker-compose
