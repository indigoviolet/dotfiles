# Used only on gcloud
#
# Copied out of zshrc (conda init zsh) and modified after install
#
# (https://aseifert.com/p/python-environments/)

# curl -LO https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-Linux-x86_64.sh
# chmod +x Mambaforge-Linux-x86_64.sh
# ./Mambaforge-Linux-x86_64.sh
# brew install micromamba (much faster)
#
# Required for mamba activate/deactivate
function conda_initialize() {

    # >>> mamba initialize >>>
    # !! Contents within this block are managed by 'mamba init' !!
    export MAMBA_EXE="/home/linuxbrew/.linuxbrew/Cellar/micromamba/1.4.1/bin/micromamba";
    export MAMBA_ROOT_PREFIX="/home/venky/.local/mambaforge";
    __mamba_setup="$("$MAMBA_EXE" shell hook --shell zsh --prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__mamba_setup"
    else
        if [ -f "/home/venky/.local/mambaforge/etc/profile.d/micromamba.sh" ]; then
            . "/home/venky/.local/mambaforge/etc/profile.d/micromamba.sh"
        else
            export  PATH="/home/venky/.local/mambaforge/bin:$PATH"  # extra space after export prevents interference from conda init
        fi
    fi
    unset __mamba_setup
    # <<< mamba initialize <<<
}

#     # eval "$(micromamba shell hook --shell=zsh)"

#     # # >>> conda initialize >>>
#     # # !! Contents within this block are managed by 'conda init' !!
#     # __conda_setup="$('/home/venky/.local/mambaforge/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
#     # if [ $? -eq 0 ]; then
#     #     eval "$__conda_setup"
#     # else
#     #     if [ -f "/home/venky/.local/mambaforge/etc/profile.d/conda.sh" ]; then
#     #         . "/home/venky/.local/mambaforge/etc/profile.d/conda.sh"
#     #     else
#     #         export PATH="/home/venky/.local/mambaforge/bin:$PATH"
#     #     fi
#     # fi
#     # unset __conda_setup

#     # if [ -f "/home/venky/.local/mambaforge/etc/profile.d/mamba.sh" ]; then
#     #     . "/home/venky/.local/mambaforge/etc/profile.d/mamba.sh"
#     # fi
#     # # <<< conda initialize <<<



#     # >>> conda initialize >>>
#     # !! Contents within this block are managed by 'conda init' !!
#     __conda_setup="$('/home/venky/.local/mambaforge/bin/conda' 'shell.zsh' 'hook' )"
#     if [ $? -eq 0 ]; then
#         eval "$__conda_setup"
#     else
#         if [ -f "/home/venky/.local/mambaforge/etc/profile.d/conda.sh" ]; then
#             . "/home/venky/.local/mambaforge/etc/profile.d/conda.sh"
#         else
#             export PATH="/home/venky/.local/mambaforge/bin:$PATH"
#         fi
#     fi
#     unset __conda_setup

#     if [ -f "/home/venky/.local/mambaforge/etc/profile.d/mamba.sh" ]; then
#         . "/home/venky/.local/mambaforge/etc/profile.d/mamba.sh"
#     fi

#     conda config --set changeps1 False
#     # <<< conda initialize <<<
# }

test -d /home/venky/.local/mambaforge && conda_initialize
