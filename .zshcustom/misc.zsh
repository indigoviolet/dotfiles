function mv-and-symlink () {
    if [[ -z $1 || -z $2 ]]
    then
        echo "No arguments provided: expected <TARGET> <DESTINATION_DIR>"
        return 1
    fi
    target=$1
    destination=$2
    if test ! -d $2
    then
        echo "$2 is not a directory"
        return 1
    fi
    mv $1 $2
    ln -s $2/$1
}

function unsymlink() {
    if [[ -z $1 ]]
    then
        echo "No arguments provided"
        return 1
    fi
    link=$1
    target=$(realpath $link)
    rm -f $link && cp -R $target $link
}


function start_script() {
    # Skip if SCRIPT_LOG_FILE is already set
    if [[ -n $SCRIPT_LOG_FILE ]]; then
        return
    fi

    export SCRIPT_LOG_DIR="${HOME}/.local/shell_logs"
    mkdir -p $SCRIPT_LOG_DIR
    export SCRIPT_LOG_FILE="${SCRIPT_LOG_DIR}/$(date -u +%Y%m%dt%H%M%S).$$.${RANDOM}.log"

    # Function to compress the log file
    function compress_log_file() {
        gzip -f $SCRIPT_LOG_FILE
    }

    # Trap to capture the exit signal and compress the log file
    trap compress_log_file EXIT

    grep -qx "$PPID" <(pgrep -x "script") || (script -q $SCRIPT_LOG_FILE)
}

# This messes with terminal resizing?
# start_script

# autoload -U modify-current-argument

# #useful when you pasted a url with lots of ^?& stuff in it
# #takes a alt-number argument to select type of quoting.
# function _quote_word()
# {
#   q=qqqq
#   modify-current-argument '${('$q[1,${NUMERIC:-1}]')ARG}'
# }

# #useful when you want to put a url back in a browser perhaps, or just
# # get the clean name of a tabcompleted file to paste somewhere else.
# function _unquote_word()
# {
#   modify-current-argument '${(Q)ARG}'
# }

# #change the quoting of a word from one type to another. If the word
# # contains spaces you can't use _unquote_word followed by _quote_word
# # since it won't be just one word by then.
# function _quote_unquote_word()
# {
#   q=qqqq
#   modify-current-argument '${('$q[1,${NUMERIC:-1}]')${(Q)ARG}}'
# }


# zle -N _quote_word
# bindkey "^Xq" _quote_word
# zle -N _unquote_word
# bindkey "^XQ" _unquote_word
# zle -N _quote_unquote_word
# bindkey "^X^[q" _quote_unquote_word
