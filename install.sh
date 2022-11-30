#!/bin/zsh

set -u

local -A opts
zparseopts -D -A opts -- -help -reset

if [[ -n "${opts[(i)--help]}" ]]; then
  echo "usage: ./setup.sh [--reset]"
else
  if [[ -n "${opts[(i)--reset]}" ]]; then
    echo "=== Remove dotfiles ==="
    cmd="rm -fv $HOME/.vimrc ; rm -rfv $HOME/.vim ; rm -fv $HOME/.bashrc; rm -fv $HOME/.screenrc; rm -fv$HOME/.vim/osc52.vim"
    eval $cmd
  
    echo "\n**************************************************\n"
  fi
  #=== Symbolic Link ===#
  echo "=== Symbolic Link ==="
  
  DOT_FILES=(.vimrc .bashrc .screenrc)
  
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
  ## iceberg
  echo "\nClone: Iceberg"
  cmd="git clone https://github.com/cocopon/iceberg.vim.git $HOME/.vim/pack/dist/colors/iceberg.vim"
  eval $cmd
  cmd="ln -s $HOME/.vim/pack/dist/colors/iceberg.vim/colors/iceberg.vim $HOME/.vim/colors/iceberg.vim"
  eval $cmd
  
  echo "done.\n"
  
  ## molokai
  echo "\nClone: Molokai"
  cmd="git clone https://github.com/tomasr/molokai $HOME/.vim/pack/dist/colors/molokai.vim"
  eval $cmd
  cmd="ln -s $HOME/.vim/pack/dist/colors/molokai.vim/colors/molokai.vim $HOME/.vim/colors/molokai.vim"
  eval $cmd

  echo "done.\n"

  # ssh越しにコピペするやつ
  echo "\nLink osc52.vim"
  
  cmd="ln -s $HOME/dotfiles/osc52.vim $HOME/.vim/osc52.vim"
  eval $cmd

  echo "done.\n"
  
  # zsh関連
  echo "\nStart: zsh related"
  ## prezto
  echo "\nClone: prezto"
  cmd='git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"'
  eval $cmd

  echo "\nSetup: prezto"
  setopt EXTENDED_GLOB
  for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
    ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
  done

  # Clone Theme
  echo "\nClone POWERLEVEL10K"
  cmd="git clone https://github.com/bhilburn/powerlevel9k.git  ~/.zprezto/modules/prompt/external/powerlevel10k"
  eval $cmd
  cmd="ln -s ~/.zprezto/modules/prompt/external/powerlevel9k/powerlevel9k.zsh-theme ~/.zprezto/modules/prompt/functions/prompt_powerlevel9k_setup"
  eval $cmd

  ## ghq
  echo "\nClone: ghq"
  git clone https://github.com/motemen/ghq $HOME/ghq
  (cd $HOME/ghq; make install)

  ## update zshrc, zpreztorc
  echo "\nUpdate: zshrc, zpreztorc"
  cmd="rm -fv $HOME/.zpreztorc; rm -fv $HOME/.zshrc"
  eval $cmd

  DOT_FILES=(.zshrc .zpreztorc .zsh_alias)
  
  for file in ${DOT_FILES[@]}
  do
    ln -s $HOME/dotfiles/$file $HOME/$file
  done

  ## go?
  cmd="mkdir $HOME/go"
  eval $cmd

  ## chsh
  echo "\nchsh: $SHELL -> /bin/zsh"
  cmd="chsh -s /bin/zsh"
  eval $cmd
  
  # End Msg.
  cat << END
  
**************************************************
  DOTFILES SETUP FINISHED!
**************************************************
 
END

fi
