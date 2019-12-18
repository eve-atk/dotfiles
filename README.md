## Installation
```
sudo apt install git zsh peco

## go環境作成
cd $HOME
wget https://dl.google.com/go/go1.13.5.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.13.5.linux-amd64.tar.gz
export PATH=$PATH:/usr/local/go/bin

## 実行
cd $HOME
git clone https://github.com/eve-atk/dotfiles.git
chmod +x dotfiles/install.sh
dotfiles/install.sh --reset
```

## Fonts
See [here](https://github.com/powerline/fonts)
