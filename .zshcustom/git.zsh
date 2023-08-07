# Install git with brew! so that completions are set up consistently
# See completions config in brew.zsh

# function _git_won() { _git_branch }
# function _git_stack() { _git_branch }
# function _git_m() { _git_branch }
# function _git_archive_branch() { _git_branch }
# function _git_restore_branch() { _git_tag }
# function _git_force_merge_theirs() { _git_branch }
# function _git_force_merge_ours() { _git_branch }

# Used in gitconfig
_gitmodified() {
    git log master.. --name-status --pretty=oneline --no-color | grep -E '^(M|A)' | cut -f2
    git status --porcelain | rev | cut -f1 -d ' ' | rev
}

# Used in gitconfig
git-modified() {
    _gitmodified | sort | uniq
}


gitinfo() {
  pushd . >/dev/null

  # Find base of git directory
  while [ ! -d .git ] && [ ! `pwd` = "/" ]; do cd ..; done

  # Show various information about this git directory
  if [ -d .git ]; then
    echo "== Remote URL: `git remote -v`"

    echo "== Remote Branches: "
    git branch -r
    echo

    echo "== Local Branches:"
    git branch
    echo

    echo "== Configuration (.git/config)"
    cat .git/config
    echo

    echo "== Most Recent Commit"
    git --no-pager log --max-count=1
    echo

    echo "Type 'git log' for more commits, or 'git show' for full commit details."
  else
    echo "Not a git repository."
  fi

  popd >/dev/null
}

# https://stackoverflow.com/a/62401418
export GIT_MERGE_AUTOEDIT=no
