#!/bin/bash

## For laptop only: on GCP, we use the script from https://cloud.google.com/compute/docs/gpus/install-drivers-gpu
##
## Taken from
## https://developer.nvidia.com/cuda-downloads?target_os=Linux&target_arch=x86_64&Distribution=Ubuntu&target_version=20.04&target_type=deb_network

set -eux

wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-ubuntu2004.pin
sudo mv cuda-ubuntu2004.pin /etc/apt/preferences.d/cuda-repository-pin-600
sudo apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/7fa2af80.pub
sudo add-apt-repository "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/ /"
sudo apt-get update

## Note: This actually didn't work the first time - it reported conflicts and I had to do
#
#$> sudo apt-get install cuda libnvidia-extra-510 nvidia-kernel-common-510 nvidia-kernel-source-510
#
sudo apt-get -y install cuda
