set shell := ["bash", "-uc"]
set positional-arguments := true

just := 'just --unstable --justfile "' + justfile() + '"'

default:
    {{ just }} --list --unsorted

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
