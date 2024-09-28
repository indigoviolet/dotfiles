# set shell := ["bash", "-uc"]
# set positional-arguments := true

# just := 'just --unstable --justfile "' + justfile() + '"'

# default:
#     {{ just }} --list --unsorted

cleanup_ediff_merge_files:
    fd "#%2Aediff-merge*" ~/dev/ -uu -x rm


# conda_cpm_t5_env:
#     delta <(conda cpm -i transformers -i tokenizers -i black -i python -i pip -i pytorch -i torchvision -i numpy -i altair -i distance -i unidecode -x t5) environment.dev.yml


# [no-cd]
# mamba_rebuild_venv ENV_FILE *args:
#     mamba env update -f {{ ENV_FILE }}  -p ./.venv "${@:2}"
#     mamba run pip install --no-build-isolation --no-deps -e .

# [no-cd]
# rebuild_venv ENV_FILE *args:
#     # micromamba create -f {{ ENV_FILE }} -p ./.venv "${@:2}"
#     micromamba update -f {{ ENV_FILE }} -p ./.venv "${@:2}"
#     # https://github.com/mamba-org/mamba/issues/2221
#     micromamba run -p ./.venv pip install $(yq e '.dependencies[] | select(has("pip")).pip[]' {{ ENV_FILE }})
#     micromamba run -p ./.venv pip install --no-build-isolation --no-deps -e .


# # run_jupyter port='55667':
# #     pkill -u venky jupyter; cd /home/venky/dev/instant-science; jupyter server --no-browser --port={{ port }} --ServerApp.iopub_data_rate_limit=1.0e10

# [no-cd]
# overmind CMD:
#     #!/usr/bin/env bash
#     set_x
#     if [[ $1 == 'start' ]]; then
#         rm -f /tmp/overmind.dl.sock; overmind start --procfile Procfile --socket /tmp/overmind.dl.sock --auto-restart jupyter --daemonize
#     else
#         overmind $1 --socket /tmp/overmind.dl.sock
#     fi


[no-cd]
clickhouse_csv csv_file *args:
    clickhouse-local --file {{ csv_file }} -N table --input-format CSV --output-format PrettyCompactMonoBlock --pager less --interactive --output_format_pretty_max_value_width 100 "${@:2}"

# Returns a list of python module names in the src/ directory
[no-cd]
@_pyflyby_modules DIR:
    # collect all .py files; format into foo.bar notation, remove .__init__ suffixes
    fd '.*\.py' . --base-directory {{ DIR }} -x echo {.} | \
        grep -v 'migrations' | \
        sed -e 's/\//./g' | \
        sed -e 's/\.__init__$//'

[no-cd]
@_pyflyby_exports DIR:
    # get all exports from modules, and print w/o formatting
    {{ just }} _pyflyby_modules {{ DIR }} | \
        xargs rye run collect-exports --width=1000 --hanging-indent=never -n

[no-cd]
@_pyflyby_imports DIR:
    # get all existing imports, but filter out those from the local module,
    # since we will add them back from _pyflyby_exports
    rye run collect-imports --width=1000 --hanging-indent=never -n . | \
        rg -v -f <({{ just }} _pyflyby_modules {{ DIR }})

[no-cd]
@_pyflyby:
    {{ just }} _pyflyby_imports src
    {{ just }} _pyflyby_exports src
    [[ -e .pyflyby.trailer ]] && cat .pyflyby.trailer

[no-cd]
gen_pyflyby:
    # do we need ruff --fix .?
    {{ just }} _pyflyby  | black -

[no-cd]
j2:
    fd '\.j2$' . -uu --max-depth 1 -x j2 {} -o {.}


# https://stackoverflow.com/a/77575171
# a script to install a specific version of a formula from homebrew-core
# USAGE: brew-switch <formula> <version>
brew-switch formula version:
    #!/usr/bin/env bash
    set -euo pipefail
    function _brew_switch() {
        local _formula=$1
        local _version=$2

        # fail for missing arguments
        if [[ -z "$_formula" || -z "$_version" ]]; then
          echo "USAGE: brew-switch <formula> <version>"
          return 1
        fi

        # ensure 'gh' is installed
        if [[ -z "$(command -v gh)" ]]; then
          echo ">>> ERROR: 'gh' must be installed to run this script"
          return 1
        fi

        # find the newest commit for the given formula and version
        local _commit_sha=$(
          gh search commits \
            --owner Homebrew \
            --repo homebrew-core \
            --limit 1 \
            --sort committer-date \
            --order desc \
            --json sha \
            --jq '.[0].sha' \
            "\"${_formula}\" \"${_version}\""
        )

        # fail if no commit was found
        if [[ -z "$_commit_sha" ]]; then
          echo "ERROR: No commit found for ${_formula}@${_version}"
          return 1
        else
          echo "INFO: Found commit ${_commit_sha} for ${_formula}@${_version}"
        fi

        # download the formula file from the commit
        local _raw_url="https://raw.githubusercontent.com/Homebrew/homebrew-core/${_commit_sha}/Formula/${_formula:0:1}/${_formula}.rb"
        local _formula_path="/tmp/${_formula}.rb"
        echo "INFO: Downloading ${_raw_url}"
        if ! curl -fL "$_raw_url" -o "$_formula_path"; then
          echo ""
          echo "WARNING: Download failed, trying old formula path"

          # try the old formula path
          _raw_url="https://raw.githubusercontent.com/Homebrew/homebrew-core/${_commit_sha}/Formula/${_formula}.rb"
          echo "INFO: Downloading ${_raw_url}"
          curl -fL "$_raw_url" -o "$_formula_path" || (echo "ERROR: Failed to download ${_raw_url}" && return 1)
        fi

        # if the formula is already installed, uninstall it
        if brew ls --versions "$_formula" >/dev/null; then
          echo ""
          echo "WARNING: '$_formula' already installed, do you want to uninstall it? [y/N]"
          local _reply=$(bash -c "read -n 1 -r && echo \$REPLY")
          echo ""
          if [[ $_reply =~ ^[Yy]$ ]]; then
            echo "INFO: Uninstalling '$_formula'"
            brew unpin "$_formula"
            brew uninstall "$_formula" || (echo "ERROR: Failed to uninstall '$_formula'" && return 1)
          else
            echo "ERROR: '$_formula' is already installed, aborting"
            return 1
          fi
        fi

        # install the downloaded formula
        echo "INFO: Installing ${_formula}@${_version} from local file: $_formula_path"
        brew install --formula "$_formula_path"
        brew pin "$_formula"
    }
    _brew_switch $@


ijq *args:
  #!/usr/bin/env bash
  if [[ -z $1 ]] || [[ $1 == "-" ]]; then
      input=$(mktemp)
      trap 'rm -f "$input"' EXIT
      cat /dev/stdin > "$input"
  else
      input=$1
  fi

  echo '' \
      | fzf --disabled \
          --preview-window='up:90%' \
          --print-query \
          --preview "jq --color-output -r {q} $input"


epipe:
  #!/usr/bin/env python
  import os
  import re
  import sys

  args = sys.argv[1:]
  if not args:
          data = sys.stdin.read()
          data = data.replace('\\', '\\\\').replace('"', '\\"')
          data = ('(let ((buf (generate-new-buffer "*stdin*")))'
                  '(switch-to-buffer buf)'
                  '(insert "' + data + '")'
                  '(goto-char (point-min))'
                  '(x-focus-frame nil)'
                  '(buffer-name buf))')
          args = ('-e', data)

  os.execlp('emacsclient', 'emacsclient', *args)
