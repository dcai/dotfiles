set -l commands load convert edit freeze import ls shell debug-info
function __fish_tmuxp_using_command
    set -l cmd (commandline -opc)
    if [ (count $cmd) -gt 1 ]
        if [ $argv[1] = $cmd[2] ]
            return 0
        end
    end
    return 1
end

complete --command tmuxp --condition "not __fish_seen_subcommand_from $commands" --keep-order --no-files -a "$commands"
complete --command tmuxp --condition '__fish_tmuxp_using_command load' --no-files -a '(tmuxp ls)'
