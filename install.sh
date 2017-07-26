#!/bin/bash
source utils/installers.sh
source utils/helpers.sh

echo_h1 "Fabriquartz Laptop Install"

# setting sudo access
fancy_echo "Sudo is required for this installation"
sudo tee /etc/sudoers.d/$USER <<END
END

echo_h1 "Preparing a few things"

fancy_echo "Please provide basic information to setup your git and ssh."

read -rp "What is your full name? (e.g. Johny Appleseed): " full_name
read -rp "What is your email address? (e.g. johny.appleseed@fabriquartz.com): " email_address

read -rp "Do you want back-end specific configuration (y/n)?" choice
case "$choice" in
  y|Y ) back_end=true;;
esac

read -rp "Do you want front-end specific configuration (y/n)?" choice
case "$choice" in
  y|Y ) front_end=true;;
esac

fancy_echo "Thank you, please confirm the info below:"

printf "\n"
printf "name:      %s\n" "$full_name"
printf "email:     %s\n" "$email_address"
printf "back-end:  %s\n" "$(echo_bool "$back_end")"
printf "front-end: %s\n" "$(echo_bool "$front_end")"

fancy_echo "Press ENTER to continue, or ctrl-c to abort"
read -r

# ==============================================================================
# prepare for install
# ==============================================================================
echo_h1 "1.0 Installing prerequisites"

fancy_echo "Creating ~/Projects/Fabriquartz"
mkdir -p ~/Projects/Fabriquartz

fancy_echo "Checking Xcode"
xcode-select -p >>/dev/null 2>&1 || install_xcode

install_brew

brew_tap 'caskroom/cask'
brew_tap 'neovim/neovim'

# ==============================================================================
# installing tools & applications
# ==============================================================================
echo_h1 "2.0 Installing tools & applications"

echo_h2 "2.1 Updating installed brew formulas"

brew_upgrade
installed=$(brew list)
installed+=$(brew cask list)

echo_h2 "2.2 Installing missing cask packages"

brew_cask_install 'google-chrome'         # duh
brew_cask_install 'visual-studio-code'    # for non-vimmers
brew_cask_install 'bettertouchtool'       # more customization
brew_cask_install 'karabiner-elements'    # for easy key remapping (eg cpslck -> esc)
brew_cask_install 'slack'                 # team communication
brew_cask_install 'postman'               # rest client
brew_cask_install 'alfred'                # enhanced launcher
brew_cask_install 'harvest'               # time tracking & billing
brew_cask_install 'docker'                # used for nginx/database
brew_cask_install 'screenhero'            # easy screensharing
brew_cask_install 'gas-mask'              # hosts-file management

echo_h2 "2.3 Installing missing brew formulas"
# tools
brew_install 'wget'                   # handy for downloading files
brew_install 'coreutils'              # ported unix commands
brew_install 'moreutils'              # more commands
brew_install 'findutils'              # even more commands
brew_install 'bash'                   # newer version than osx default
brew_install 'git'                    # git cli
brew_install 'hub'                    # github cli
brew_install 'git-standup'            # see commits last day
brew_install 'the_silver_searcher'    # enhanced searcher with ag
brew_install 'postgresql'             # database
brew_install 'redis'                  # dependency for rails
brew_install 'ctags'                  # indexer for vim
brew_install 'libyaml'                # dependency for rails
brew_install 'colordiff'              # fancy colors for diffs
brew_install 'shellcheck'             # linter for bash/sh
brew_install 'neovim'                 # preffered editor
# languages
brew_install 'nvm'                    # node version management
brew_install 'python3'                # python 3
brew_install 'node'                   # node
brew_install 'elixir'                 # elixir
# completions
brew_install 'bash-completion2'
brew_install 'brew-cask-completion'
brew_install 'bundler-completion'
brew_install 'cap-completion'
brew_install 'docker-completion'
brew_install 'gem-completion'
brew_install 'mix-completion'
brew_install 'open-completion'
brew_install 'rails-completion'
brew_install 'rake-completion'
brew_install 'ruby-completion'

echo_h2 "2.3 Installing npm packages"

npm_install 'npm'                         # node package manager
npm_install 'tern'                        # js indexer

echo_h2 "2.4 Cleaning up installations"

fancy_echo "Cleaning brew"
brew cleanup >> out.log 2>&1
brew cask cleanup >> out.log 2>&1

# ==============================================================================
# installing dotfiles
# ==============================================================================
echo_h1 "3.0 Copying dotfiles"

install_dotfile "aliases"
install_dotfile "agignore"
install_dotfile "bash_profile"
install_dotfile "bashrc"
install_dotfile "bash_prompt"
install_dotfile "exports"
install_dotfile "editorconfig"
install_dotfile "gitconfig"
install_dotfile "gitignore"
install_dotfile "inputrc"

# ==============================================================================
# running some custom installations
# ==============================================================================
echo_h1 "4.0 Installing & Configuring"

echo_h2 "4.1 Configuring neovim"
install_neovim

if [ "$back_end" = true ]; then
  echo_h2 "4.2 Back end Confuguration"
  source ./back-end.sh
fi

if [ "$front_end" = true ]; then
  echo_h2 "4.2 Front end Confuguration"
  source ./front-end.sh
fi

# ==============================================================================
# setting up ssh
# ==============================================================================

echo_h2 "4.3 Configuring ssh"

if file_exists ~/.ssh/id_rsa; then
  fancy_echo "Key found, skipping generation"
else
  fancy_echo "Generating key"
  ssh-keygen -q -t rsa -b 4096 -C "$email_address" -N "" -f ~/.ssh/id_rsa
  pbcopy < ~/.ssh/id_rsa.pub
  fancy_echo "Copied public key to clipboard, please add it to github: https://github.com/settings/keys"
fi

# ==============================================================================
# setting up git
# ==============================================================================

echo_h2 "4.4 Configuring git"
fancy_echo "Setting name & email"
git config --global user.name "$full_name"
git config --global user.email "$email_address"

# ==============================================================================
# configuring a few more things
# ==============================================================================

echo_h2 "4.5 Configuring redis"

fancy_echo "Set redis as launchAgent"
ln -sfv /usr/local/opt/redis/*.plist ~/Library/LaunchAgents >> out.log 2>&1

echo_h2 "4.6 Configuring OSX"

fancy_echo "Enabling hidden files in Finder"
defaults write com.apple.finder AppleShowAllFiles TRUE

fancy_echo "Enabling Full file path in Finder"
defaults write com.apple.finder _FXShowPosixPathInTitle -bool YES

killall Finder

fancy_echo "Setting scrollbar visibility"
defaults write com.apple.Terminal AppleShowScrollBars -string WhenScrolling

fancy_echo "Disabling smart quotes and dashes"
defaults write -g NSAutomaticDashSubstitutionEnabled 0
defaults write -g NSAutomaticQuoteSubstitutionEnabled 0

fancy_echo "Disabling auto open downloads in Safari"
defaults write com.apple.Safari AutoOpenSafeDownloads -boolean NO

fancy_echo "Making KeyRepeat faster"
defaults write -g InitialKeyRepeat -int 15 # normal minimum is 15 (225 ms)
defaults write -g KeyRepeat -int 3 # normal minimum is 2 (30 ms)

fancy_echo "Configuring shell"
sudo sh -c 'echo /usr/local/bin/bash >> /etc/shells'
sudo chsh -s /usr/local/bin/bash "$USER"

# ==============================================================================
# done
# ==============================================================================

# revoking sudo access
sudo /bin/rm "/etc/sudoers.d/${USER}"
sudo -k

echo_h1 "finsished installation"
exec /usr/local/bin/bash -l
