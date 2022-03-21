# shellcheck disable=SC1090
#
layout_conda() {
  local ACTIVATE="${HOME}/miniconda3/bin/activate"

  if [ -n "$1" ]; then
    # Explicit environment name from layout command.
    local env_name="$1"
  elif (grep -q name: environment.yml); then
    source "$ACTIVATE" "${env_name}"
    # Detect environment name from `environment.yml` file in `.envrc` directory
    source "$ACTIVATE" "$(grep name: environment.yml | sed -e 's/name: //' | cut -d "'" -f 2 | cut -d '"' -f 2)"
  else
    (echo >&2 No environment specified)
    exit 1
  fi
}

# Local Variables:
# sh-shell: bash
# End:
