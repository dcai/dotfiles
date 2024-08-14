if type "docker" &>/dev/null; then
  eval "$(docker-machine env default &>/dev/null)"
fi
