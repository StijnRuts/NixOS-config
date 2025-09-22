#!/usr/bin/env bash

function search {
  if [ -z "$query" ]; then
    echo "No search string given"
    exit 1
  fi

  zoxide_search
  navigate

  find_search
  navigate

  echo "No matching directories found"
  exit 1
}

function zoxide_search {
  matches=$(zoxide query --list "$query")
}

function find_search {
  if command -v fd &>/dev/null; then
    matches=$(fd --type d "$query" ~ 2>/dev/null)
  else
    matches=$(find ~ -type d -iname "*$query*" 2>/dev/null)
  fi
}

function navigate {
  readarray -t list < <(echo "$matches")
  if [ ${#list[@]} -eq 0 ] || [ -z "${list[0]}" ]; then
    return
  elif [ ${#list[@]} -eq 1 ]; then
    echo "${list[0]}"
    exit 0
  else
    select_from_list
    echo "$selected"
    exit 0
  fi
}

function select_from_list {
  if command -v fzf &>/dev/null; then
    select_fzf
  else
    select_builtin
  fi
}

function select_fzf {
  selected=$(
    echo "$matches" | fzf \
      --prompt="Select directory > " \
      --height=6 --style=minimal \
      --layout=reverse --info=hidden
  )
}

function select_builtin {
  PS3="Select a directory: "
  select selected in "${list[@]}"; do
    if [ -n "$selected" ]; then
      return
    fi
  done
}

query="$*"
search
