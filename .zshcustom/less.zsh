export LESS="-g -i -M -S --use-color -z-4 -R"

## Makes less slower
export LESSOPEN="|$HOMEBREW_PREFIX/bin/lesspipe.sh %s"
