fancy_echo() {
  local fmt="$1"; shift
  printf "\n$fmt\n" "$@"
}

fancy_echo "This script will setup your laptop"

# Get name and email
fancy_echo "Before we start we need some basic details of you"
read -p "What is your full name? (e.g. Johny Appleseed): " full_name
read -p "What is your email address? (e.g. johny.appleseed@fabriquartz.com): " email_address

fancy_echo "Hello $full_name <$email_address>"

fancy_echo "Press any key to start the installation process, press <CTRL + C> to cancel"
read

fancy_echo "We need your sudo password to do a few things"
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &


if ! command -v brew >/dev/null; then
  fancy_echo "Installing Brew"
  curl -fsS \
    'https://raw.githubusercontent.com/Homebrew/install/master/install' | ruby
else
  fancy_echo "Updating Brew ..."
  brew update >> out.log
fi

fancy_echo "Installing Brew formulas!"

brew_install() {
  if brew list -1 | grep -Fqx "$1"; then
    if ! brew outdated --quiet "$1" >/dev/null; then
      printf "Upgrading %s ... \n" "$1"
      brew upgrade "$@" >> out.log 2>&1
    else
      printf "Already installed %s\n" "$1"
    fi
  else
    printf "Installing %s ...\n" "$1"
    brew install "$@" >> out.log 2>&1
  fi
}

brew_cask_install() {
  if brew cask list -1 | grep -Fqx "$1"; then
    printf "Already installed %s\n" "$1"
  else
    printf "Installing %s ...\n" "$1"
    brew cask install "$@" >> out.log 2>&1
  fi
}

brew_install 'wget'
brew_install 'coreutils'
brew_install 'moreutils'
brew_install 'findutils'
brew_install 'bash'
brew_install 'bash-completion2'
brew_install 'git'
brew_install 'vim'
brew_install 'the_silver_searcher'
brew_install 'watchman'
brew_install 'node'
brew_install 'nvm'
brew_install 'hub'
brew_install 'elixir'
brew_install 'postgresql'
brew_install 'redis'
brew_install 'ctags'
brew_install 'libyaml'
brew_install 'colordiff'

brew_install 'openssl'
brew unlink openssl       >> out.log 2>&1
brew link openssl --force >> out.log 2>&1

copy_dotfile() {
  if [ -f ~/.${1} ]
  then
    diff=$(colordiff -u ~/.${1} ./dotfiles/${1})
    if [[ $(echo "$diff" | wc -l) -gt 1 ]]
    then
      printf "Updating %s\n" "$1"
      printf "Changes:\n"
      printf "\n$diff\n\n"
      mv ~/.${1} ~/.${1}.backup$(date +%s)
    else
     printf "Copying %s\n" "$1"
    fi
    unset diff
  fi

  cp ./dotfiles/${1} ~/.${1}
}

fancy_echo "Copying dotfiles!"
copy_dotfile "aliases"
copy_dotfile "agignore"
copy_dotfile "bash_profile"
copy_dotfile "bashrc"
copy_dotfile "bash_prompt"
copy_dotfile "exports"
copy_dotfile "editorconfig"
copy_dotfile "gitconfig"
copy_dotfile "gitignore"
copy_dotfile "inputrc"
copy_dotfile "vimrc"

fancy_echo "Do 'rm ~/*.backup*' to cleanup the backed up dotfiles"

printf "\n"
if brew list -1 | grep -Fqx 'neovim'; then
  printf "Upgrading NeoVim ...\n"
  brew reinstall --HEAD neovim >> out.log 2>&1
else
  printf "Installing NeoVim ...\n"
  brew tap neovim/neovim >> out.log 2>&1
  brew install --HEAD neovim >> out.log 2>&1
fi

printf "\n"
brew tap homebrew/versions >> out.log 2>&1
brew_install 'caskroom/cask/brew-cask'

brew_cask_install 'google-chrome'
brew_cask_install 'visual-studio-code'
brew_cask_install 'dash'
brew_cask_install 'slack'
brew_cask_install 'alfred'
brew_cask_install 'harvest'
brew_cask_install 'virtualbox'
brew_cask_install 'vagrant'
brew_cask_install 'screenhero'

fancy_echo "Updating misc Brew packages (if any)"
brew upgrade >> out.log 2>&1

fancy_echo "Cleaning up all the Brew spills"
brew cleanup >> out.log 2>&1
brew cask cleanup >> out.log 2>&1

npm_install() {
  printf "Installing %s ...\n" "$1"
  npm install -g "$@" >> out.log 2>&1
}

fancy_echo "Installing NPM packages"
npm_install 'npm'
npm_install 'bower'
npm_install 'phantomjs'
npm_install 'ember-cli'
npm_install 'nombom'

fancy_echo "Creating folder ~/Project/Fabriquartz"
mkdir -p ~/Projects/Fabriquartz

if [ -f ~/.ssh/id_rsa ]
then
  fancy_echo "Skipping SSH key generation, you already have one"
else
  fancy_echo "Generating SSH key"
  ssh-keygen -q -t rsa -b 4096 -C "$email_address" -N "" -f ~/.ssh/id_rsa
fi

cat ~/.ssh/id_rsa.pub | pbcopy
fancy_echo "\nCopyied public key to clipboard, please add it to your Github account."

fancy_echo "Linking .vimrc to .nvimrc for NeoVim users"
mkdir ~/.config >> out.log 2>&1
ln -s ~/.vim ~/.config/nvim >> out.log 2>&1
ln -s ~/.vimrc ~/.config/nvim/init.vim >> out.log 2>&1

fancy_echo "Configuring name and email in .gitconfig"
git config --global user.name "$full_name"
git config --global user.email "$email_address"

printf "\n"
if ! command -v rvm >/dev/null; then
  fancy_echo "Installing the Ruby version manager"
  \curl -sSL https://get.rvm.io | bash -s stable --ruby >> out.log 2>&1
else
  fancy_echo "Updating the Ruby version manager"
  rvm get stable >> out.log 2>&1
fi

rvm install 2.2.3 2>&1
gem install bundler 2>&1

fancy_echo "Installing vim plugins"
vim +NeoBundleInstall +qall

fancy_echo "Changing system Bash to newer Brew Bash"
fancy_echo "If this fails, please do `chsh -s /usrl/local/bin/bash` manually"
sudo bash -c "echo /usr/local/bin/bash >> /private/etc/shells"
chsh -s /usr/local/bin/bash

fancy_echo "Reloading shell"
exec $SHELL -l

fancy_echo "\n\n\nDone!"
