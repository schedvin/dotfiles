#!/usr/bin/env bash

set -e

sudo apt install ansible -y

export PATH="$PATH:~/.local/bin"

if [ ! -f "__bootstraped__" ]; then
  ansible-playbook --ask-become-pass ~/dotfiles/bootstrap.yml
  touch __bootstraped__
fi

if [ -f "__bootstraped__" ]; then
  ansible-galaxy install -r requirements.yml
fi
