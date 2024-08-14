function fish_prompt --description 'Write out the prompt'
    switch $USER
        case root
            set -g __fish_prompt_symbol ' # '
        case '*'
            set -g __fish_prompt_symbol ' > '
    end
    echo -n (set_color green)(prompt_pwd)(set_color normal)"$__fish_prompt_symbol"
    set_color normal
end
