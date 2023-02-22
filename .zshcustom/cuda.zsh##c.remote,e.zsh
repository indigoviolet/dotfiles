## https://github.com/GoogleCloudPlatform/compute-gpu-installation/blob/32845620c0cc8168cd4a689dc7c3aab28afc4b35/linux/install_gpu_driver.py#L346
if [[ -e "/etc/profile.d/cuda.sh" ]]; then
    source /etc/profile.d/cuda.sh
elif [[ -e "/etc/profile.d/nvidia-env.sh" ]]; then
    source /etc/profile.d/nvidia-env.sh
fi
