#!/usr/bin/env bash

# Install command-line tools using Homebrew.

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Check for Homebrew,
# Install if we don't have it
if test ! $(which brew); then
  echo "Installing homebrew..."
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  sudo chown -R $(whoami) /usr/local
fi

# Make sure we’re using the latest Homebrew.
brew update

# Install data stores
brew install mariadb
mysql_install_db
brew install postgresql
brew install mongo
brew install redis
brew install elasticsearch

# Install mysql workbench
# Install Cask
brew tap caskroom/cask
brew cask install --appdir="/Applications" mysqlworkbench

# Remove outdated versions from the cellar.
brew cleanup