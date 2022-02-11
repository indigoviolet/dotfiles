#!/bin/zsh

# To get retry()
source ${ZSH_CUSTOM_DIR}/scriptlib.zsh

set -eux

# https://docs.docker.com/engine/install/ubuntu/#install-using-the-convenience-script
# This stupidly fails with some postinstall error:
#
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
#
# So we use the retry() function defined in scriptlib.zsh to try it twice, it
# seems to succeed the second time
#
retry 2 bash -c "curl https://get.docker.com | sh"

# https://docs.docker.com/engine/security/rootless/
sudo apt-get install --no-install-recommends -y uidmap
dockerd-rootless-setuptool.sh install --force

# test (see .zshcustom/docker.zsh for export of variables)
DOCKER_HOST=unix:///run/user/$UID/docker.sock docker run hello-world

# disable system-wide service
sudo systemctl disable --now docker.service docker.socket

# enable user service
systemctl --user restart docker.service
loginctl enable-linger

# ------------- #
# nvidia-docker #
# ------------- #

# https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html#pre-requisites
distribution=$(
    . /etc/os-release
    # 20.04 is latest at this time
    # echo ${ID}${VERSION_ID}
    echo ${ID}20.04
) &&
    curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add - &&
    curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list

sudo apt-get update && sudo apt-get install --no-install-recommends -y nvidia-docker2
systemctl --user restart docker.service

## Change settings to allow GPUs to be used by container in rootless mode
## https://github.com/NVIDIA/nvidia-docker/issues/1155
toml_file='/etc/nvidia-container-runtime/config.toml'
selector='.nvidia-container-cli.no-cgroups'
current_no_cgroups=$(dasel -f $toml_file $selector || echo 'false')
[[ ${current_no_cgroups:-'false'} == 'true' ]] || {
    echo 'Editing $toml_file:'
    sudo cp $toml_file ${toml_file}.bak &&
        sudo_with_env dasel put bool -f $toml_file $selector 'true'
}

pipx install docker-compose
