#!/bin/bash
install_brew() {
  if ! command_exists 'brew'; then
    fancy_echo "Installing Brew"
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" >> out.log 2>&1 </dev/null
    # install casks in /Applications
    export HOMEBREW_CASK_OPTS="--appdir=/Applications"

  if ! command_exists 'brew'; then
    fancy_echo "Failed to install brew"
    exit
  fi

  else
    fancy_echo "Found Brew"
  fi
}

remove_rvm() {
rvm implode --force >>/dev/null 2>&1
gem uninstall rvm >>out.log 2>&1
}

install_xcode() {
  xcode-select --install
  read -rp "Press ENTER to continue"
}

install_neovim() {
  fancy_echo "Copying files"
  mkdir -p ~/.config/nvim
  mkdir -p ~/.config/nvim/UltiSnips

  for file in neovim/UltiSnips/*.snippets; do
    file=$(basename "$file")
    backup_if_different "./neovim/UltiSnips/$file" "$HOME/.config/nvim/UltiSnips/$file"
    cp "./neovim/UltiSnips/$file" "$HOME/.config/nvim/UltiSnips/$file"
  done

  for file in neovim/*.vim; do
    file=$(basename "$file")
    backup_if_different "./neovim/$file" "$HOME/.config/nvim/$file"
    cp "./neovim/$file" "$HOME/.config/nvim/$file"
  done

  fancy_echo "Setting up plugins"

  pip3 install --user neovim >> out.log 2>&1
  nvim +PlugInstall +qall >>/dev/null
}

install_oracle() {
  unzip -qu 'assets/instantclient-all-macos.x64-12.1.0.2.0.zip' -d ~/Library/Caches/Homebrew
  brew_install 'instantclient-basic'
  brew_install 'instantclient-sdk'
  brew_install 'instantclient-sqlplus'
  oci_dir=$(brew --prefix)/lib
  sudo /bin/bash -c 'echo "127.0.0.1 ${HOSTNAME}" >> /etc/hosts' >>out.log 2>&1
  export OCI_DIR=$oci_dir
}

install_dotfile() {
  printf "Installing dotfile %s\n" "${1}"
  backup_if_different "./dotfiles/${1}" "$HOME/.${1}"
  cp "./dotfiles/${1}" "$HOME/.${1}"
}

brew_tap() {
  printf "Tapping %s\n" "$1"
  brew tap "$1" >> out.log 2>&1
}

gem_install() {
  if ! gem list | grep -q "$1"; then
    printf "Installing %s\n" "$1"
    gem install "$1" --no-doc >> out.log 2>&1
  else
    printf "Found %s\n" "$1"
  fi
}

brew_install() {
  if ! installed "$1" ; then
    printf "Installing %s\n" "$1"
    brew install "$1" >> out.log 2>&1
  else
    printf "Found %s\n" "${1}"
  fi
}

brew_upgrade() {
  if [ "$(brew outdated | wc -l)" -gt 0 ]; then
    fancy_echo "Updating the following formulas:"
    brew outdated
    brew upgrade >> out.log 2>&1
  else
    fancy_echo "No outdated formulas found"
  fi
}

brew_cask_install() {
  if ! installed "$1"; then
    printf "Installing %s\n" "${1}"
    brew cask install "$1" >> out.log 2>&1
  else
    printf "Found %s\n" "${1}"
  fi
}

npm_install() {
  printf "Installing %s\n" "${1}"
  npm install -g "$1" >> out.log 2>&1
}
