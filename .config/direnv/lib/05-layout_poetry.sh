# shellcheck disable=SC2155
# shellcheck disable=SC2016
#
# https://unix.stackexchange.com/a/506355
#
layout_poetry() {
  if [[ ! -f pyproject.toml ]]; then
    log_error 'No pyproject.toml found.  Use `poetry new` or `poetry init` to create one first.'
    exit 2
  fi

  # As of <2022-02-04 Fri>:
  #
  # poetry 1.2+ uses a new installer install-poetry.py which always uses the
  # version of Python used to install poetry.
  #
  # In our usage, this would mean that the global version of Python (set by asdf)
  # at the time of Poetry install would get used for all virtualenvs, which is not
  # desirable.
  #
  # See discussion in:
  #
  # - https://github.com/asdf-community/asdf-poetry/issues/10
  # - https://github.com/python-poetry/poetry/pull/4852 (experimental poetry option virtualenvs.prefer-active-python, not yet released at time of writing)
  #
  # To work around this, we force poetry to always use the current asdf-mandated
  # version. If this version doesn't match the current venv version, Poetry will
  # re-create the environment
  #
  #
  # This prints out the same info as `poetry env info --path`
  local VENV="$(poetry env use $(rtx which python) -v --no-ansi | awk '{print $3}')"

  if [[ -z $VENV || ! -d $VENV/bin ]]; then
    log_error "No created poetry virtual environment found.  Use 'poetry install' to create one first. (venv=$VENV or $VENV/bin not found)"
    exit 2
  fi
  export VIRTUAL_ENV=$VENV POETRY_ACTIVE=1
  PATH_add "$VENV/bin"

  # # compare $VENV/bin/python to version set in .tool-versions and throw error if
  # # they don't match. Since we do `poetry env use` above, this error will never
  # # get thrown
  # local poetry_python_version=$(python -V | awk '{print $2}')
  # local asdf_python_version=$(asdf current python | awk '{print $2}')
  # if test $poetry_python_version != $asdf_python_version; then
  #   log_error "Poetry Python version: <$poetry_python_version> != asdf Python version: <$asdf_python_version>"
  #   exit 2
  # fi
}

# Local Variables:
# sh-shell: bash
# End:
