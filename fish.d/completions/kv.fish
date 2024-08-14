set -l kv_sub_commands set get rm rename export
function __fish_kv_using_command
    set -l cmd (commandline -opc)
    if [ (count $cmd) -gt 1 ]
        if [ $argv[1] = $cmd[2] ]
            return 0
        end
    end
    return 1
end

complete --command kv --condition "not __fish_seen_subcommand_from $kv_sub_commands" --keep-order --no-files -a "$kv_sub_commands"
complete --command kv --condition '__fish_kv_using_command get' --no-files -a '(kv get --keys)'
complete --command kv --condition '__fish_kv_using_command rm' --no-files -a '(kv get --keys)'
complete --command kv --condition '__fish_kv_using_command rename' --no-files -a '(kv get --keys)'
