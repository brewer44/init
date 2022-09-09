#!/bin/bash
# Auhtor: Brewer Johnson
# Description: Local env creation
# Version:
#   1.0:May 12 2021: Inital script creation. 

#get os version
#OS=""
#if [ /usr/bin/sw_vers ]; do
#    OS="MAC"
#elif [ cat /etc/redhat-release ]; do 
#    OS="RHEL"
#fi

#for linux

# for macos
#homebrew install 
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"


brew install --cask iterm2
brew install --cask clipy
brew install --cask spectacle
investigate_pkgs="ack" 
libs_pkgs="gettext gdbm icu4c id3lib libidn2 libunistring ncurses pcre2 readline wimlib"
dev_pkgs="firefox git gitnote go jq node oniguruma openjdk openssl@1.1 python@3.9 sqlite vagrant vagrant-completion visual-studio-code"
kube_pkgs="helm kubernetes-helm rke rancher-cli"
docker_pkgs="docker docker-completion"
tools_pkgs="agedu csvkit fping lynx mysql-client nmap spectacle telnet vault watch wget"
brew_per_pkgs="bash_completion discord keybase mpdecimal signal spotify tcl-tk tree wtf wtfutil xz youtube-dl youtube-to-mp3"
retired="vivaldi lens"

echo "Installing Dev packages"
for itr in $(echo $dev_pkgs); do
    brew install $itr
done
echo "Installing Kube packages"
for itr in $(echo $kube_pkgs); do
    brew install $itr
done
echo "Installing Docker packages"
for itr in $(echo $docker_pkgs); do
    brew install $itr
done
echo "Install Tools"
for itr in $(echo $tools_pkgs); do
    brew install $itr
done
echo "Install personal packages"
for itr in $(echo $brew_per_pkgs); do
    brew install $itr
done
#echo "Just in case, installing other libs that were on legacy instances"
#brew install $libs_pkgs
 
#echo "*************************"
#echo "Brew set up complete. Moving on to manual set ups"
#echo ""

echo "Grabbing bash_profile"
wget https://raw.githubusercontent.com/brewer44/init/main/bash_profile > ~/.bash_profile

echo "Setting up Personal extra dirs"
mkdir ~/git
mkdir ~/sandbox

#TODO: auto make up k8s config?

#TODO: auto pull down standard ssh config?

