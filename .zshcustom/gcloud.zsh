export CLOUDSDK_PYTHON=python3 # prevent it from looking for python2, python2.7
if [ -e $HOMEBREW_PREFIX/share/google-cloud-sdk/path.zsh.inc ]; then
    source $HOMEBREW_PREFIX/share/google-cloud-sdk/path.zsh.inc
fi
