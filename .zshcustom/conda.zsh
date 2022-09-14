# Used only on gcloud
#
# Copied out of zshrc (conda init zsh) and modified after install
#
# (https://aseifert.com/p/python-environments/)

# curl -LO https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-Linux-x86_64.sh
# chmod +x Mambaforge-Linux-x86_64.sh
# ./Mambaforge-Linux-x86_64.sh

# Required for mamba activate/deactivate
function conda_initialize() {
    # >>> conda initialize >>>
    # !! Contents within this block are managed by 'conda init' !!
    __conda_setup="$('$CONDA_PATH/bin/conda' 'shell.zsh' 'hook' 2>/dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "$CONDA_PATH/etc/profile.d/conda.sh" ]; then
            . "$CONDA_PATH/etc/profile.d/conda.sh"
        else
            export PATH="$CONDA_PATH/bin:$PATH"
        fi
    fi
    unset __conda_setup

    if [ -f "$CONDA_PATH/etc/profile.d/mamba.sh" ]; then
        . "$CONDA_PATH/etc/profile.d/mamba.sh"
    fi

    conda config --set changeps1 False
    # <<< conda initialize <<<
}

CONDA_PATH="/home/venky/.local/mambaforge"
test -d $CONDA_PATH && conda_initialize
