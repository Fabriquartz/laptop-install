# ==============================================================================
# Back end specific installation
# ==============================================================================

echo_h2 "Installing ruby environment"

if command_exists 'rvm'; then
  fancy_echo "Removing rvm"
  remove_rvm
fi

brew_install 'rbenv'
brew_install 'rbenv-gemset'

eval "$(rbenv init -)"

ruby_version='2.3.1'

if ! rbenv versions | grep -q "$ruby_version"; then
  printf "Installing ruby %s\n" "$ruby_version"
  rbenv install "$ruby_version" >>out.log 2>&1
else
  printf "Found ruby %s\n" "$ruby_version"
fi

rbenv global "$ruby_version"

echo_h2 "Installing oracle instant client"

brew_tap 'InstantClientTap/instantclient'
install_oracle

# -----------------------------------------------------------------------------
# Gems
# ------------------------------------------------------------------------------

echo_h2 "Installing missing gems"

gem_install 'bundler'
gem_install 'rubocop'

fancy_echo "cleaning gems"
gem cleanup >> out.log 2>&1
