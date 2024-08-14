set LOCAL_PROXY (kv get proxy)

function proxyOn
    if count $argv >/dev/null
        set LOCAL_PROXY $argv[1]
    end
    printf "Enabling proxy ($LOCAL_PROXY)...\n"
    set -gx HTTPS_PROXY "$LOCAL_PROXY"
    set -gx HTTP_PROXY "$LOCAL_PROXY"
    git config --global http.proxy "$LOCAL_PROXY"
    npm config set proxy "$LOCAL_PROXY"
    printf "Done\n"
end

function proxyOff
    printf "Stopping proxy...\n"
    set -e HTTPS_PROXY
    set -e HTTP_PROXY
    git config --global --unset-all http.proxy
    npm config rm proxy
    printf "Done\n"
end
