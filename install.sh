#!/bin/zsh

set -e

if [[ -e ~/.zsh_aliases ]]; then
    echo "This installation script has already been run and is not idempotent. Are you sure you want to continue? [Y/n]"
    read confirm
    if [[ $confirm == "n" ]]; then
        echo "goodbye"
        return
    fi
fi

# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# install brew
sudo xcode-select --install
sh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zshrc
echo "Added brew environment setup to ~/.zshrc"

# install nerdtree vim plugin
mkdir -p ~/.vim/autoload ~/.vim/bundle && curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
git clone https://github.com/preservim/nerdtree.git ~/.vim/bundle/nerdtree

# install all ~/.*rc files to configure env, add aliases to .zshrc
PWD=$(pwd)
mv $PWD/.git $PWD/git
cp $PWD/.* ~/
echo "source ~/.zsh_aliases" >> ~/.zshrc
cat >> ~/.zshrc << EOM
if [[ -z $WAS_SOURCED ]]; then
    source ~/.zsh_aliases
    eval "$(/opt/homebrew/bin/brew shellenv)"
    WAS_SOURCED=1
fi
EOM
source ~/.zshrc
mv $PWD/git $PWD/.git
