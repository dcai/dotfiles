#!/bin/bash

# essentials

/opt/homebrew/bin/brew install fish iterm2

echo /opt/homebrew/bin/fish | sudo tee -a /etc/shells
chsh -s /opt/homebrew/bin/fish

# dev must have
brew install --cask hammerspoon the-unarchiver raycast slack postman uninstallpkg espanso

brew install \
    aria2 \
    aspell ispell \
    bat \
    colordiff \
    coreutils \
    dfc \
    direnv \
    duf \
    exiftool \
    fd \
    fish \
    gawk \
    git \
    git-delta \
    git-tig \
    gnu-sed \
    gnupg2 \
    gopass \
    htop \
    imagemagick \
    iproute2mac \
    jpeg \
    jq \
    lsd \
    macchina fastfetch \
    ncdu \
    openssl \
    pandoc \
    pcre pcre2 \
    pv \
    python3 \
    qpdf \
    rg \
    rsync \
    sponge \
    tokei \
    tmux tmuxp \
    tree \
    vim neovim \
    viu \
    watch \
    xz \
    yarn \
    yt-dlp \
    yq

echo "# coding things"
brew install \
    black \
    eslint \
    golang \
    gopls \
    isort \
    lua-language-server \
    luacheck \
    luajit \
    prettier \
    pyright \
    shellcheck \
    shfmt \
    stylua \
    tree-sitter \
    typescript \
    typescript-language-server \
    virtualenv

# nerd fonts
brew tap homebrew/cask-fonts
brew install font-iosevka-term-nerd-font

echo "# clang"
brew install clang-format llvm cmake
# brew install -f gdu
# brew link --overwrite gdu # if you have coreutils installed as well

# docker stuff
# brew install ctop lazydocker

echo "# dotnet stuff"
brew install --cask dotnet-sdk

echo "# db cli stuff"
brew install litecli mycli pgcli

# cloud stuff
# brew install aws-cdk awscli azure-cli google-cloud-sdk

echo "# motd stuff"
brew install lolcat fortune

echo "# home computer must have"
brew install --cask bartender iina v2rayu dropbox wechat itsycal visual-studio-code

## Universal Ctags (abbreviated as u-ctags) is a maintained implementation of ctags
# brew install --HEAD universal-ctags/universal-ctags/universal-ctags

echo "# asdf"
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.0
asdf plugin add nodejs 'https://github.com/asdf-vm/asdf-nodejs.git'
# asdf instal nodejs 18.17.0
# asdf global nodejs 18.17.0
asdf global nodejs system
# arch -x86_64 asdf install nodejs 12.9.1

echo "# npm packages"
npm i -g neovim cspell
