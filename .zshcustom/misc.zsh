function confirm () {
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
