#!/bin/bash

# General configuration
my_loc=$(dirname $(readlink -f -- ${BASH_SOURCE[0]}))




if [ -d "$HOME/.config/zellij" ]
then
  echo -e "\e[33m Zellij config directory exists, skipping.\e[0m"
else
  ln -s "$my_loc/zellij" "$HOME/.config/"
fi

if [ -d "$HOME/.config/lvim" ]
then
  echo -e "\e[33m Lunarvim config directory exists, skipping.\e[0m"
else
  ln -s "$my_loc/lunarvim/" "$HOME/.config/lvim"
fi
