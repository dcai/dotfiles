function fzf-oneliners-widget -d "Show oneliners"
    set -q FZF_TMUX_HEIGHT; or set FZF_TMUX_HEIGHT 40%
    begin
        set -lx FZF_DEFAULT_OPTS "--height $FZF_TMUX_HEIGHT $FZF_DEFAULT_OPTS"
        # (commandline) read current line content
        one | eval fzf -q '(commandline)' | read -l result
        and commandline -- $result
    end
    commandline -f repaint
end

function fzf-kubens -d kubens
    set -q FZF_TMUX_HEIGHT; or set FZF_TMUX_HEIGHT 40%
    begin
        set -lx KUBECTX_IGNORE_FZF 1
        set -lx FZF_DEFAULT_OPTS "--height $FZF_TMUX_HEIGHT $FZF_DEFAULT_OPTS"
        # (commandline) read current line content
        kubectl get namespace --no-headers | awk '{print $1}' | eval fzf -q '(commandline)' | read -l var_kubenamespace
        and commandline -- "kubens $var_kubenamespace"
    end
    commandline -f repaint
end

function fish_user_key_bindings
    fish_default_key_bindings
    fzf_key_bindings
    bind \co fzf-oneliners-widget
    bind \ck fzf-history-widget
    # bind \ck fzf-kubens
end
