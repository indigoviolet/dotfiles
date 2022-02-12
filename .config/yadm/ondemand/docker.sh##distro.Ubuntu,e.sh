#!/bin/bash
# Warning


# [[file:docker.org::*Warning][Warning:1]]
# Do not edit this file, tangle from docker.org
# Warning:1 ends here

# Header

# [[file:docker.org::*Header][Header:1]]
# To get retry()
source ${ZSH_CUSTOM_DIR}/scriptlib.zsh

set -eux
# Header:1 ends here

# Install using convenience script

# https://docs.docker.com/engine/install/ubuntu/#install-using-the-convenience-script

# This stupidly fails with some postinstall error:

# #+begin_example
# Job for docker.service failed because the control process exited with error code.
# See "systemctl status docker.service" and "journalctl -xe" for details.
# invoke-rc.d: initscript docker, action "start" failed.
# ● docker.service - Docker Application Container Engine
#      Loaded: loaded (/lib/systemd/system/docker.service; enabled; vendor preset: enabled)
#      Active: activating (auto-restart) (Result: exit-code) since Wed 2022-02-09 17:42:54 PST; 5ms ago
# TriggeredBy: ● docker.socket
#        Docs: https://docs.docker.com
#     Process: 2401832 ExecStart=/usr/bin/dockerd -H fd:// --containerd=/run/containerd/containerd.sock (code=exited, status=1/FAILURE)
#    Main PID: 2401832 (code=exited, status=1/FAILURE)
# dpkg: error processing package docker-ce (--configure):
# #+end_example

# So we use the retry() function defined in scriptlib.zsh to try it twice, it
# seems to succeed the second time



# [[file:docker.org::*Install using convenience script][Install using convenience script:1]]
retry 2 bash -c "curl https://get.docker.com | sh"
# Install using convenience script:1 ends here

# nvidia-docker


# [[file:docker.org::*nvidia-docker][nvidia-docker:1]]
# https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html#pre-requisites
distribution=$(
    . /etc/os-release
    # 20.04 is latest at this time
    # echo ${ID}${VERSION_ID}
    echo ${ID}20.04
) &&
    curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add - &&
    curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list

sudo apt-get update && sudo apt-get install --no-install-recommends -y nvidia-container-toolkit
# nvidia-docker:1 ends here

# Restart docker


# [[file:docker.org::*Restart docker][Restart docker:1]]
sudo systemctl restart docker.service
# Restart docker:1 ends here

# Testing


# [[file:docker.org::*Testing][Testing:1]]
docker run hello-world
sudo docker run --rm --gpus all --ipc=host nvidia/cuda:11.6.0-base-ubuntu20.04 nvidia-smi
# Testing:1 ends here

# docker-compose


# [[file:docker.org::*docker-compose][docker-compose:1]]
pipx install docker-compose
# docker-compose:1 ends here
