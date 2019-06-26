#!/bin/zsh

set -u

local -A opts
zparseopts -D -A opts -- -help -reset

if [[ -n "${opts[(i)--help]}" ]]; then
  echo "usage: ./setup.sh [--reset]"
else
  if [[ -n "${opts[(i)--reset]}" ]]; then
    echo "=== Remove dotfiles ==="
    cmd="rm -fv $HOME/.vimrc ; rm -rfv $HOME/.vim ; rm -fv $HOME/.bashrc"
    eval $cmd
  
    echo "\n**************************************************\n"
  fi
  #=== Symbolic Link ===#
  echo "=== Symbolic Link ==="
  
  DOT_FILES=(.vimrc .bashrc)
  
  for file in ${DOT_FILES[@]}
  do
    ln -s $HOME/dotfiles/$file $HOME/$file
  done
  
  echo "done.\n"
  
  #=== Vim ===#
  echo "=== .Vim ==="
  
  cmd="mkdir --parents $HOME/.vim/colors"
  eval $cmd
  
  cmd="mkdir --parents $HOME/.vim/pack/dist/start"
  eval $cmd
  
  cmd="mkdir --parents $HOME/.vim/pack/dist/opt"
  eval $cmd
  
  cmd="mkdir --parents $HOME/.vim/pack/dist/colors"
  eval $cmd
  
  # Clone Color Scheme
  echo "\nClone: Iceberg"
  cmd="git clone https://github.com/cocopon/iceberg.vim.git $HOME/.vim/pack/dist/colors/iceberg.vim"
  eval $cmd
  cmd="ln -s $HOME/.vim/pack/dist/colors/iceberg.vim/colors/iceberg.vim $HOME/.vim/colors/iceberg.vim"
  eval $cmd
  
  echo "done.\n"
  
  # End Msg.
  cat << END
  
**************************************************
  DOTFILES SETUP FINISHED!
**************************************************
 
END

fi

source ~/.bashrc
