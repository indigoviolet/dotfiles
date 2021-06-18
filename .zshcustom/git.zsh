zstyle ':completion:*:*:git:*' script ${ZSH_CUSTOM_DIR}/git-completion.bash
fpath=(${ZSH_CUSTOM_DIR} $fpath)

function _git_won() { _git_branch }
function _git_stack() { _git_branch }
function _git_m() { _git_branch }
function _git_archive_branch() { _git_branch }
function _git_restore_branch() { _git_tag }
function _git_force_merge_theirs() { _git_branch }
function _git_force_merge_ours() { _git_branch }

_gitmodified() {
    git log master.. --name-status --pretty=oneline --no-color | grep -E '^(M|A)' | cut -f2
    git status --porcelain | rev | cut -f1 -d ' ' | rev
}

git-modified() {
    _gitmodified | sort | uniq
}

# Will return the current branch name
# Usage example: git pull origin $(current_branch)
# Using '--quiet' with 'symbolic-ref' will not cause a fatal error (128) if
# it's not a symbolic ref, but in a Git repo.
function current_branch() {
  local ref
  ref=$($_git_cmd symbolic-ref --quiet HEAD 2> /dev/null)
  local ret=$?
  if [[ $ret != 0 ]]; then
    [[ $ret == 128 ]] && return  # no git repo.
    ref=$($_git_cmd rev-parse --short HEAD 2> /dev/null) || return
  fi
  echo ${ref#refs/heads/}
}

function current_repository() {
  if ! $_git_cmd rev-parse --is-inside-work-tree &> /dev/null; then
    return
  fi
  echo $($_git_cmd remote -v | cut -d':' -f 2)
}


# Delete merged branched.
function git-cleanup() {
  zparseopts -a opts f q h i d
  local curb merged
  local force interactive
  local from_branches='^(master|dev)$'
  local keep_branches='^(master|dev|local)$'

  if (( $opts[(I)-h] )); then
    echo "Cleans merged branches."
    echo "$0 [-i] [-f] [-q]"
    return
  fi
  interactive=$opts[(I)-i]
  force=$opts[(I)-f]
  dry_run=$opts[(I)-d]

  merged=($(git branch --merged | sed '/^*/d' | cut -b3- | sed "/$keep_branches/d"))

  local cmd
  cmd=(git branch -d)
  if (( $dry_run )); then
    cmd=(echo $cmd)
  fi

  if (( $interactive )); then
    echo "$#merged branches to process: " $merged

    for b in $merged; do
      view +'set ft=diff' =(echo "== $b =="; git show $b)
      printf "Delete? "
      read -q || { echo; continue }; echo
      $cmd $b
    done
  else
    $cmd $merged
  fi
}

function git-migrate () {
  branch_name=$(git symbolic-ref -q HEAD)
  branch_name=${branch_name##refs/heads/}
  branch_name=${branch_name:-HEAD}
  new_branch_name=${branch_name}-migrations

  git checkout master && git checkout -b ${new_branch_name} && git checkout ${branch_name} db/migrate && git commit -m "Add migrations from ${branch_name}"
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

function git-reviewers() {
    hub pr list --format="%rs,%au,%as%n" --limit=100 --state="closed" | perl -lane 's/\s//g; s/^,//; print join("\n", split(",", $_))' | sort | uniq
}

function git-reviewers-cached() {
    cache_file=/tmp/git-reviewers.$(pwd | perl -lpe 's{/}{-}g;').cache
    cache_seconds=86400
    if [ -f $cache_file ] && [ "$(( $(date +"%s") + $cache_seconds ))" -ge "$(date -r $cache_file +"%s")" ]; then
      cat $cache_file
    else
      git-reviewers | tee $cache_file
    fi
}

function git-select-reviewers() {
    git-reviewers-cached | fzf -m --prompt="Reviewers: " | perl -0777 -lne 's/\s+$//g; s/\s/,/g; print "$_"'
}

function git-fin-core-pr () {
    hub pull-request --edit --push -f --reviewer=$(git-select-reviewers) --browse $*
}

