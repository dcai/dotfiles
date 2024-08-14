####################################################################
### std environment vars
####################################################################
set -gx UID (id -u)
set -gx XDG_CACHE_HOME "$HOME/.cache"
set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx XDG_DATA_HOME "$HOME/.local/share"
set -gx XDG_STATE_HOME "$HOME/.local/state"
set -gx DROPBOX_HOME "$HOME/Dropbox"

# https://wiki.gentoo.org/wiki/XDG_directories
if test -z "$XDG_RUNTIME_DIR"
    set -gx XDG_RUNTIME_DIR "/tmp/$UID-runtime-dir"
    if not test -d "$XDG_RUNTIME_DIR"
        mkdir "$XDG_RUNTIME_DIR"
        chmod 0700 "$XDG_RUNTIME_DIR"
    end
end

if type -q nvim
    set -gx EDITOR nvim
else
    set -gx EDITOR vim
end
set -gx COLORON true
set -gx LC_ALL en_US.UTF-8
set -gx PAGER less
set -gx TIME_STYLE long-iso
####################################################################
### fish
####################################################################
set -gx FISHHOME "$XDG_CONFIG_HOME/fish"
set -gx fish_prompt_pwd_dir_length 0
####################################################################
### cli apps vars
####################################################################
set -gx RIPGREP_CONFIG_PATH "$HOME/.ripgreprc"
set -gx FUNCTIONS_CORE_TOOLS_TELEMETRY_OPTOUT 1
set -gx DOTNET_CLI_TELEMETRY_OPTOUT 1
# set -gx LESSOPEN '|pygmentize %s'
####################################################################
set -gx GOPATH "$HOME/go"
set -gx NODEJS_CHECK_SIGNATURES no
# set -gx NODE_TLS_REJECT_UNAUTHORIZED 0
set -gx PNPM_HOME "$XDG_DATA_HOME/pnpm"
set -gx MODULAR_HOME "$HOME/.modular"
set -gx DOTNET_ROOT $HOME/dotnet
set -gx CARGO_HOME $HOME/.cargo
set -gx RUSTUP_HOME $HOME/.rustup
set -gx COMPOSER_HOME $XDG_CONFIG_HOME/composer
set -gx COMPOSER_BIN_DIR $COMPOSER_HOME/vendor/bin

function source_script
    test -f $argv[1]; and source $argv[1]
end

# function prepend_one_path --description 'Prepend a directory to $PATH'
#     if contains $argv[1] $fish_user_paths
#         return
#     end
#     if test -d $argv[1]
#         set --global --prepend fish_user_paths $argv[1]
#     end
# end

function prepend_paths --description 'Prepend a list of paths to $PATH'
    for p in $argv
        fish_add_path --prepend --global $p
    end
end

function iprintf --description "echo in interactive mode only"
    if status --is-interactive
        printf $argv[1]
    end
end

###### Ruby
# if type -q ruby
#     set -l RUBYGEMHOME (ruby -r rubygems -e "puts Gem.user_dir")
#     prepend_one_path "$RUBYGEMHOME/bin"
# end

set uname (uname -s)
set arch (uname -m)

if test "$uname" = Darwin
    switch $arch
        case i386
            if test -f /usr/local/bin/brew
                eval (/usr/local/bin/brew shellenv)
                prepend_paths \
                    /usr/local/opt/mysql-client/bin \
                    /usr/local/opt/openjdk/bin
            end
        case arm64
            if test -f /opt/homebrew/bin/brew
                eval (/opt/homebrew/bin/brew shellenv)
                prepend_paths \
                    /opt/homebrew/bin \
                    /opt/homebrew/sbin
                prepend_paths \
                    /opt/homebrew/opt/mysql-client/bin \
                    /opt/homebrew/opt/openjdk/bin
            end
    end
    prepend_paths \
        ~/Library/Python/2.7/bin \
        ~/Library/Python/3.7/bin \
        ~/Library/Python/3.8/bin \
        ~/Library/Python/3.9/bin \
        ~/Library/Python/3.10/bin \
        ~/Library/Python/3.11/bin \
        ~/Library/Python/3.12/bin
end

prepend_paths \
    # ~/.asdf/bin \
    # ~/.asdf/shims
    ~/.cabal/bin \
    ~/.dotnet/tools \
    ~/.rover/bin \
    $MODULAR_HOME/pkg/packages.modular.com_mojo/bin \
    ~/.npm-packages/bin \
    $PNPM_HOME \
    $HOME/.bun/bin \
    $HOME/.dotnet/tools \
    $COMPOSER_BIN_DIR \
    $DOTNET_ROOT \
    "$GOPATH/bin" \
    "$CARGO_HOME/bin" \
    ~/.bin \
    ~/.local/bin

####################################################################
### my custom vars
###    after all paths set
####################################################################
set -gx OPENAI_API_MODEL gpt-4o
set -gx OPENAI_API_KEY (kv get OPENAI_API_KEY)
set -gx ANTHROPIC_API_KEY (kv get ANTHROPIC_API_KEY)
set -gx GOOGLEAI_API_KEY (kv get GOOGLEAI_API_KEY)
set -gx GROQ_API_KEY (kv get GROQ_API_KEY)
set -gx GITHUB_TOKEN (kv get GITHUB_TOKEN)
set -gx GITHUB_ACCESS_TOKEN (kv get GITHUB_TOKEN)
set -gx DOKU_TOKEN (kv get DOKU_TOKEN)

set -gx CODESTATS_API_KEY (kv get CODESTATS_API_KEY)
set -gx CODESTATS_API_URL (kv get CODESTATS_API_URL)

set -gx MAILGUN_DOMAIN (kv get MAILGUN_DOMAIN)
set -gx MAILGUN_SECRET (kv get MAILGUN_SECRET)

set -gx FZF_DEFAULT_OPTS '--height 60% --layout=reverse --bind ctrl-b:preview-half-page-up,ctrl-f:preview-half-page-down'
set -gx FZF_DEFAULT_COMMAND 'rg --files --sortr=modified --color never --hidden --column'

if type -q bat
    set -gx MANPAGER "sh -c 'col -bx | bat -l man -p'"
end

# if ! command --search fd >/dev/null do
#     if ! command --search fdfind >/dev/null do
#         alias fd="find . -iname"
#     else
#         # findfd is installed
#         set -gx FZF_DEFAULT_COMMAND 'fdfind --type f'
#         alias fd="fdfind"
#     end
# else
#     # fd is isntalled
#     set -gx FZF_DEFAULT_COMMAND 'fd --type f'
# end

# if ! command --search zoxide >/dev/null do
#     printf "zoxide is not installed\n"
# else
#     zoxide init fish | source
# end

set -l TABTAB_PATH "$HOME/.config/tabtab/fish/__tabtab.fish"
if test -f "$TABTAB_PATH"
    source $TABTAB_PATH
    complete --no-file --description "pnpm completion script" --command p --argument "(_pnpm_completion)"
end

if type -q mise
    mise activate fish | source
else
    # [ -f $HOME/.asdf/asdf.fish ]; and source $HOME/.asdf/asdf.fish
end
