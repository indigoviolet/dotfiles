set shell := ["bash", "-uc"]
set positional-arguments := true

just := 'just --unstable --justfile "' + justfile() + '"'

default:
    {{ just }} --list --unsorted

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
