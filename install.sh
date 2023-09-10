#!/usr/bin/env bash

set -e
export ANSIBLE_NOCOWS=1

DOTFILES_DIR="$HOME/dotfiles"

if ! [ -x "$(command -v ansible)" ]; then
  sudo apt install -y ansible
fi

export PATH="$PATH:~/.local/bin"

force=0

while getopts 'fh' opt; do
  case "$opt" in
    f)
      force=1
      ;;
    h)
      echo "Usage: $(basename $0) [-f]"
      echo "  -f: Force bootstrap"
      exit 0
      ;;
    ?)
      echo "Usage: $(basename $0) [-f]"
      exit 1
      ;;
  esac
done

if [[ ! -f "__bootstraped__" || $force -eq 1 ]]; then
  ansible-playbook --ask-become-pass ~/dotfiles/bootstrap.yml
  touch __bootstraped__
fi
