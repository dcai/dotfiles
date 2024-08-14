if status --is-interactive
    # abbr -a -g rg cg
    abbr -a -g mongod 'mongod --config /opt/homebrew/etc/mongod.conf'
    abbr -a -g dfc 'watch -c -n 30 dfc -c always'
    abbr -a -g ld 'tree --dirsfirst -aFCNL 1'
    abbr -a -g lld 'tree --dirsfirst -ChFupDaLg 1'
    abbr -a -g mux 'tmuxp load'
    abbr -a -g pywatch 'while true; find . -iname "*.py" | entr -rdc poetry run test; end'
    # abbr -a -g vd "env HTTPS_PROXY='http://127.0.0.1:1087/' annie -aria2"
    abbr -a -g vim-plug-update "vim +'PlugUpdate --sync' +qall"
    abbr -a -g wget "curl -C - -O"
    abbr -a -g nodemon "NODE_ENV=local npx nodemon -r dotenv/config"
    abbr -a -g behat-init "php admin/tool/behat/cli/init.php -j=1 --axe -a=classic"
    abbr -a -g mp3-dl 'youtube-dl --extract-audio --audio-format mp3 '
    abbr -a -g unset 'set --erase'
    abbr -a -g weather 'curl wttr.in/Sydney'
    abbr -a -g brwe brew
    abbr -a -g hasura 'hasura --skip-update-check'
    abbr -a -g virtualenv 'python3 -m venv ./venv'
    abbr -a -g venv 'python3 -m venv ./venv'
    abbr -a -g shrc "exec $SHELL -l"
end
