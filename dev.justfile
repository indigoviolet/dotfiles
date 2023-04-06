set shell := ["bash", "-uc"]
set positional-arguments := true

just := 'just --unstable --justfile "' + justfile() + '"'

default:
    {{ just }} --list --unsorted

conda_cpm_t5_env:
    delta <(conda cpm -i transformers -i tokenizers -i black -i python -i pip -i pytorch -i torchvision -i numpy -i altair -i distance -i unidecode -x t5) environment.dev.yml


[no-cd]
rebuild_venv ENV_FILE *args:
    mamba env update -f {{ ENV_FILE }}  -p ./.venv "$@"
    direnv reload
    pip install --no-build-isolation --no-deps -e .

[no-cd]
micro_rebuild_venv ENV_FILE *args:
    # https://github.com/mamba-org/mamba/issues/2221
    # micromamba update -f {{ ENV_FILE }}  -p ./.venv "$@"
    mamba env update -f {{ ENV_FILE }}  -p ./.venv "$@"#
    direnv reload
    pip install --no-build-isolation --no-deps -e .


THELIO_HOST := `tailscale status --json | jq -r '.Peer[] | select(.HostName == "thelio") | .DNSName | rtrimstr(".")'`

thelio_ssh:
    ssh {{ THELIO_HOST }}


run_jupyter port='55667':
    # should be run on thelio
    pkill -u venky jupyter; cd /home/venky/dev/instant-science; jupyter server --no-browser --port={{ port }}

[no-cd]
overmind CMD:
    #!/usr/bin/env bash
    # should be run on thelio
    set_x
    if [[ $1 == 'start' ]]; then
        rm -f /tmp/overmind.dl.sock; overmind start --procfile Procfile --socket /tmp/overmind.dl.sock --auto-restart jupyter --daemonize
    else
        overmind $1 --socket /tmp/overmind.dl.sock
    fi


[no-cd]
clickhouse_csv csv_file *args:
    clickhouse-local --file {{ csv_file }} -N table --input-format CSV --output-format PrettyCompactMonoBlock --pager less --interactive --output_format_pretty_max_value_width 100 "${@:2}"
