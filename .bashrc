# alias系
alias ll="ls -al --color"
alias vless="/usr/share/vim/vim[0-9][0-9]/macros/less.sh"

# 色設定
export PS1="\[\e[1;34m\][\u@\h \W]\\$ \[\e[m\]"
export LSCOLORS=gxfxcxdxbxegedabagacad

# 環境固有設定の読み込み
if [ -e ~/.bash_profile ]; then
    source ~/.bash_profile
fi
