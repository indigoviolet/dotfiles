function confirm {
    # call with a prompt string or use a default
    p=$( [[ -n $1 ]] &&  echo "$1 [y/N]" )
    read "response?${p:-Are you sure? [y/N]}"
    case $response in
        [yY][eE][sS]|[yY])
            true;;
        *)
            false;;
    esac
}


# https://gist.github.com/sj26/88e1c6584397bb7c13bd11108a579746
# Retry a command up to a specific numer of times until it exits successfully,
# with exponential back off.
#
#  $ retry 5 echo Hello
#  Hello
#
#  $ retry 5 false
#  Retry 1/5 exited 1, retrying in 1 seconds...
#  Retry 2/5 exited 1, retrying in 2 seconds...
#  Retry 3/5 exited 1, retrying in 4 seconds...
#  Retry 4/5 exited 1, retrying in 8 seconds...
#  Retry 5/5 exited 1, no more retries left.
#
function retry {
  local retries=$1
  shift

  local count=0
  until "$@"; do
    exit=$?
    wait=$((2 ** $count))
    count=$(($count + 1))
    if [ $count -lt $retries ]; then
      echo "Retry $count/$retries exited $exit, retrying in $wait seconds..."
      sleep $wait
    else
      echo "Retry $count/$retries exited $exit, no more retries left."
      return $exit
    fi
  done
  return 0
}


function sudo_with_env () {
    local SUDO_EDITOR=$(which $EDITOR)
    set -x
    sudo -E env PATH=$PATH SUDO_EDITOR=$SUDO_EDITOR "$@"
}


# Checks if a directory is already in $PATH
function is_dir_in_path() {
  local dir=$1
  [[ -z "$dir" ]] && {
    print "Usage: is_dir_in_path <directory>"
    return 2
  }

  if (( ${+path[(r)$dir]} )); then
    return 0  # Found
  else
    return 1  # Not found
  fi
}

# Prepends a directory to $PATH if not present
function prepend_path_if_missing() {
  local dir=$1
  [[ -z "$dir" ]] && {
    print "Usage: prepend_path_if_missing <directory>"
    return 1
  }

  if ! is_dir_in_path "$dir"; then
    path=("$dir" $path)
  fi
}
