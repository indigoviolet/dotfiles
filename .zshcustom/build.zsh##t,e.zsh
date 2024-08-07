# WARNING: Do not edit this file.
# It was generated by processing {{ yadm.source }}

# Build flags etc. This is not in env.zsh because env.zsh is sourced in .zprofile as well

{% if yadm.os == "Linux" %}
# For libpng (pdf-tools), emacs build etc.
BREW_PREFIX=$(brew --prefix)

export BREW_PKG_CONFIG=$BREW_PREFIX/lib/pkgconfig:$BREW_PREFIX/share/pkgconfig

# Unclear if I should be setting these -- we seem to do CC= a lot
# export PKG_CONFIG_PATH=$BREW_PKG_CONFIG:/usr/lib/x86_64-linux-gnu/pkgconfig:/usr/share/pkgconfig

# #
# # * For python-build, use Brew (libffi.so.8)
# #
# # For python-build, esp. on 20.04, where python-build wants libffi.so.8, but
# # "apt libffi-dev" only provides libffi.so.7 (see
# # https://dev.to/ajkerrigan/homebrew-pyenv-ctypes-oh-my-3d9)
# #
# # * For emacs build, we want to use the apt gcc-11 (libgccjit)
# #
# # unset it like so:
# #
# # > CC= <command>
# export CC="$(brew --prefix gcc)/bin/gcc-12"

export MAKEFLAGS="-j $(nproc)"

{% endif %}

# # PIPX_DEFAULT_PYTHON: see `pipx install -h`. By default this is a vendored Python, we use it from rye
# #
# # this requires rye toolchain fetch 3.11.3
# export PIPX_DEFAULT_PYTHON=$(rye toolchain list --format json | jq -r '.[] | select(.name=="cpython@3.11.6") | .path')
