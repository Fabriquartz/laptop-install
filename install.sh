# Setup project folder
mkdir -p ~/Projects/Fabriquartz

# Install Homebrew
if ! command -v brew >/dev/null; then
  curl -fsS \
    'https://raw.githubusercontent.com/Homebrew/install/master/install' | ruby
fi

brew update
brew upgrade

brew install wget
brew install coreutils
brew install moreutils
brew install findutils

brew install bash
brew tap homebrew/versions
brew install bash-completion2

brew install git
brew install vim
brew install the_silver_searcher

brew install openssl
brew unlink openssl && brew link openssl --force

# Install node.js & npm
brew install node

# Install Homebrew-Cask
brew install caskroom/cask/brew-cask

# Install Apps
brew cask install google-chrome
brew cask install sublime-text
brew cask install dash
brew cask install alfred
brew cask install slack
brew cask install harvest

brew cleanup

npm install npm -g; npm update -g
npm install -g bower
npm install -g phantomjs
npm install -g ember-cli

if ! command -v rvm >/dev/null; then
  \curl -sSL https://get.rvm.io | bash -s stable --ruby
else
  rvm get stable
  rvm reload
fi

source ~/.rvm/scripts/rvm
