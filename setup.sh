#!/bin/bash

set -e 
HOME=~

function copyFile {
  filename="$(basename $1)"
  if [ -e "${HOME}/${filename}" ]; 
  then
    echo "File ${filename} exists, skipping"
  else
    cp "$1" "${HOME}/" 
  fi
}

for file in $(find ./place_in_homedir/ -type f);
do
  copyFile ${file}
done

file="${HOME}/.gitconfig"
if [ -e "${file}" -o -h "${file}" ]; then 
  echo "Gitconfig exists, not replacing"
else
  ln -s gitconfig "${HOME}/.gitconfig"
fi

if [ -e "${HOME}/.zshrc" ]; then
  echo "source ~/dotfiles/aliases" >> ${HOME}/.zshrc
fi
