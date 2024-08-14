#!/bin/bash
RCROOT="$HOME/etc"

if [ ! -z $1 ]; then
    RCROOT="$1"
fi

CMD="ln -s"

while [[ $# -gt 0 ]]; do
    key="$1"
    case $key in
        --src)
            RCROOT="$2"
            shift
            shift
            ;;
    esac
done

if [[ ! -d "$RCROOT" ]]; then
    echo "ERROR: \`${RCROOT}\` is not a valid directory"
    exit 1
fi

TARGET_HOME_DIR=$HOME
TARGET_XDG_CONFIG="$TARGET_HOME_DIR/.config"
TARGET_PREFERENCES_DIR="$TARGET_HOME_DIR/Library/Preferences"
TARGET_APPLIATION_SUPPORT_DIR="$TARGET_HOME_DIR/Library/Application Support"
LOCAL_BIN_DIR=${TARGET_HOME_DIR}/.local/bin

entering() {
    echo "### $1: $2"
}

linking() {
    echo "-> Linking $1 to $2"
}

CONFIG_FILES_HOME_DIR="
.ctags
.curlrc
.editorconfig
.gemrc
.ignore
.npmrc
.ripgreprc
.rgignore
.tigrc
.tmux.conf
.wgetrc
"

CONFIG_FILES_XDG="
pip
rss2email.cfg
aria2
starship.toml
"

CONFIG_FILES_PREFERENCES="
doublecmd
org.videolan.vlc
"

entering "HOME" "$TARGET_HOME_DIR"
cd $TARGET_HOME_DIR
for f in $CONFIG_FILES_HOME_DIR; do
    rm -rf "$TARGET_HOME_DIR/$f"
    linking "$RCROOT/${f#?}" "$TARGET_HOME_DIR/$f"
    eval "$CMD" "$RCROOT/${f#?}" $f
done

### bash
# rm -f .profile
# rm -f .bashrc
# rm -f .bash_profile
# eval "$CMD" "$TARGET_HOME_DIR/.bash.d/bashrc" .bashrc
# eval "$CMD" "$TARGET_HOME_DIR/.bash.d/bashrc" .bash_profile
### gitconfig.local
# rm -rf "$TARGET_HOME_DIR/.gitconfig.local"
# touch "$TARGET_HOME_DIR/.gitconfig.local"
# echo "
# [user]
#   name = Dongsheng Cai
#   email = d@tux.im
# " | tee "$TARGET_HOME_DIR/.gitconfig.local" &>/dev/null
### XDG
# mkdir -p $TARGET_XDG_CONFIG
# entering "XDG" "$TARGET_XDG_CONFIG"
# cd $TARGET_XDG_CONFIG
# for dir in $CONFIG_FILES_XDG; do
#   rm -rf "$TARGET_XDG_CONFIG/$dir"
#   linking "$RCROOT/$dir" "$TARGET_XDG_CONFIG/$dir"
#   eval "${CMD}" "$RCROOT/$dir" $dir
# done

# if [ "$(uname)" == "Darwin" ]; then
#   #ln -s "/Applications" "$TARGET_HOME_DIR/Applications"
#   entering "Preferences" "$TARGET_PREFERENCES_DIR"
#   cd $TARGET_PREFERENCES_DIR
#   for dir in $CONFIG_FILES_PREFERENCES; do
#     rm -rf "$TARGET_PREFERENCES_DIR/$dir"
#     linking "$RCROOT/$dir" "$TARGET_PREFERENCES_DIR/$dir"
#     eval "${CMD}" "$RCROOT/$dir" $dir
#   done
#
#   VSCODE_DIR="$TARGET_APPLIATION_SUPPORT_DIR/Code/User"
#   entering "VSCODE DIR" "$VSCODE_DIR"
#   mkdir -p "$VSCODE_DIR" && cd "$VSCODE_DIR"
#   rm -f settings.json
#   eval "${CMD}" "$RCROOT/vscode_settings.json" settings.json
# fi
# if [ ! -d "${TARGET_XDG_CONFIG}/fish" ]; then
#   echo "## Copying fish shell config"
#   git clone https://github.com/dcai/.fish.d.git "${TARGET_XDG_CONFIG}/fish"
# fi
# if [ ! -d "${TARGET_HOME_DIR}/.bash.d" ]; then
#   echo "## git clone .bash.d => ${TARGET_HOME_DIR}/.bash.d"
#   git clone https://github.com/dcai/.bash.d.git "${TARGET_HOME_DIR}/.bash.d"
#   rm "${TARGET_HOME_DIR}/.bash_profile"
#   ln -s "${TARGET_HOME_DIR}/.bash.d/bashrc" ${TARGET_HOME_DIR}/.bash_profile
# fi
#
# if [ ! -d "${TARGET_XDG_CONFIG}/git" ]; then
#   echo "## .config/git"
#   git clone https://gist.github.com/2885623.git "${TARGET_XDG_CONFIG}/git"
# fi
# DIR=${TARGET_HOME_DIR}/.hammerspoon
# if [ ! -d $DIR ]; then
#   echo "## hammerspoon config $DIR"
#   git clone https://github.com/dcai/.hammerspoon.git $DIR
# fi
# DIR="${TARGET_HOME_DIR}/.password-store"
# if [ ! -d $DIR ]; then
#   echo "## password store $DIR"
#   git clone https://github.com/dcai/.password-store.git $DIR
# fi
#
# DIR="${TARGET_HOME_DIR}/.tmuxp"
# if [ ! -d $DIR ]; then
#   echo "## tmuxp profiles $DIR"
#   git clone https://github.com/dcai/.tmuxp.git $DIR
# fi
#BINFILE="/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl"
#if [ ! -f "$BINFILE" ]; then
#  mkdir -p $LOCAL_BIN_DIR
#  ln -s $BINFILE $LOCAL_BIN_DIR
#fi

DIR="${TARGET_HOME_DIR}/Downloads/fonts"
if [ ! -d $DIR ]; then
    echo "## powerfonts $DIR"
    git clone --depth=1 https://github.com/powerline/fonts.git $DIR
    bash ${DIR}/install.sh
fi

DIR=${TARGET_HOME_DIR}/.fzf
if [ ! -d $DIR ]; then
    echo "## Installing fzf $DIR"
    git clone --depth 1 https://github.com/junegunn/fzf.git $DIR
    bash ${DIR}/install --all
fi

if [ ! -d "${TARGET_HOME_DIR}/.vim" ]; then
    echo "## Copying vim config"
    git clone https://github.com/dcai/.vim.git "${TARGET_HOME_DIR}/.vim"
fi

if [ ! -d "$TARGET_HOME_DIR/.gnupg" ]; then
    echo "## Copying gnupg"
    cp -r "$RCROOT/gnupg" "$TARGET_HOME_DIR/.gnupg"
else
    echo "## gnupg folder not found"
fi
