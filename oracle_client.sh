fancy_echo() {
  local fmt="$1"; shift
  printf "\n$fmt\n" "$@"
}

fancy_echo "This script will help you install the Oracle client"

fancy_echo "Before you can get started  you will need to download a few packages:"

echo "  - (64-bit) Instant Client - Basic Lite"
echo "  - (64-bit) Instant Client - SDK"

fancy_echo "Please ensure these packages are downloaded to ~/Downloads as .zip files"

fancy_echo "Press any key to open the download page ..."
read
open "http://www.oracle.com/technetwork/topics/intel-macsoft-096467.html"

fancy_echo "Press any key when you are done downloading the packages"
read

fancy_echo "Installing instant client!"

ln -sf ~/Downloads/instantclient-basiclite-macos.x64-12.1.0.2.0.zip ~/Library/Caches/Homebrew/
ln -sf ~/Downloads/instantclient-sdk-macos.x64-12.1.0.2.0.zip ~/Library/Caches/Homebrew/

brew install InstantClientTap/instantclient/instantclient-basiclite
brew install InstantClientTap/instantclient/instantclient-sdk

export OCI_DIR=$(brew --prefix)/lib

fancy_echo "Done!"
