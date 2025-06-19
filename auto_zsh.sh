#!/bin/sh


if ! command -v apt &> /dev/null; then
  INSTALL="apt"
elif ! command -v yum &> /dev/null; then
  INSTALL="yum"
fi

if command -v zsh &> /dev/null; then
  sudo $INSTALL install zsh -y
fi

if command -v git &> /dev/null; then
  sudo $INSTALL install git -y
fi

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

sed -i 's/ZSH_THEME=".*"/ZSH_THEME="powerlevel10k\/powerlevel10k"/g' ~/.zshrc
sed -i 's/plugins=(\(.*\))/plugins=(\1 zsh-syntax-highlighting zsh-autosuggestions)/' ~/.zshrc

if [ "$(grep "^$USER" /etc/passwd | grep -o '[^/]*$')" != "zsh" ]; then
  chsh -s /bin/zsh
fi
