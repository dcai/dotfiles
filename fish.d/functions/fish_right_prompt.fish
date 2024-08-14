# function fish_right_prompt --description 'fish right prompt'
#     if not set -q __git_cb
#         # set __git_cb " ["(set_color brown)(git branch ^/dev/null | grep \* | sed 's#* ##')(set_color normal)"]"
#         set __git_cb " ("(set_color -d red)(git rev-parse --abbrev-ref HEAD ^/dev/null)(set_color normal)")"
#     end
#
#     printf '%s' $__git_cb
# end
