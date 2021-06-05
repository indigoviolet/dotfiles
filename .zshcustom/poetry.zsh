# Poetry
path+=$(asdf where poetry)/bin

function make_easy_install_pth () {
    # Workaround to add an easy-install.pth file for all "poetry
    # develop = true" editable installs so mypy can follow
    # https://github.com/python-poetry/poetry/issues/3094#issuecomment-707172704

    set -x
    site_packages=$(fd -u 'site-packages' --type d -1 $VIRTUAL_ENV)

    # the sed command adds newlines after each file
    fd -u 'pth' $site_packages -E 'easy-install.pth' -X sed -e '$s/$/\n/' -s {} > $site_packages/easy-install.pth
}

function poetry_init () {
    set -x
    poetry init -n
    poetry install
    echo 'layout_poetry' > .envrc
    direnv allow
}
