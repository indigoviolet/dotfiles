# Used only on gcloud
#
# Copied out of zshrc (conda init zsh) and modified after install
# wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
# chmod +x Miniconda-latest-Linux-x86_64.sh
# ./Miniconda-latest-Linux-x86_64.sh

function conda_initialize()  {
    # >>> conda initialize >>>
    # !! Contents within this block are managed by 'conda init' !!
    __conda_setup="$('$CONDA_PATH/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
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
    # <<< conda initialize <<<
}

CONDA_PATH="/home/venky/miniconda3"
test -d $CONDA_PATH && conda_initialize
