export LESS="-g -i -M -S --use-color -z-4 -R"

## Makes less slower
(( $+commands[lesspipe.sh] )) && export LESSOPEN="|$(command -v lesspipe.sh) %s"
