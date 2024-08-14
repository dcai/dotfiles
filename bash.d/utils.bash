launch() {
  ("$@" &>/dev/null &)
}

gbk2utf() {
  iconv -f gb18030 -t utf-8 "$1" >"$1.out"
}

gbk2utfbulk() {
  for file in *.$1; do
    iconv -f gb18030 -t utf-8 "$file" >"$file.out"
    mv "$file.out" "$file"
  done
}

fixid3() {
  #search package: mutagen
  find . -iname "*.mp3" -execdir mid3iconv -e gbk {} \;
}

bulk_unzip() {
  for i in *.zip; do
    mkdir "$(basename "$i" .zip)"
    unzip "$i" -d "$(basename "$i" .zip)"
  done
}

# zzz() {
# ${1%/} removes the trailing slash
# echo "ZIP ${1%/}"
# zip -r "./${1%/}.zip" "$1"
# }
# xxx() {
# INFILE="${1%/}"
# TARGETFILE="${INFILE}.tar.xz"
# tar c "$1" | xz -v >"$TARGETFILE"
### xz -l "$TARGETFILE"
# }

## ex - archive extractor
# usage: ex <file>
# from: https://bbs.archlinux.org/viewtopic.php?pid=609235#p609235
ex() {
  if [[ -f "$1" ]]; then
    case "$1" in
    *.tar.bz2 | *.tbz2) tar xjf "$1" ;;
    *.tar.xz) tar xJf "$1" ;;
    *.tar.gz) tar xzf "$1" ;;
    *.bz2) bunzip2 "$1" ;;
    *.rar) unrar x "$1" ;;
    *.gz) gunzip "$1" ;;
    *.tar) tar xf "$1" ;;
    *.tgz) tar xzf "$1" ;;
    *.zip | *.jar) unzip "$1" ;;
    *.Z) uncompress "$1" ;;
    *.7z) 7z x "$1" ;;
    *.xz) xz -d "$1" ;;
    *) echo "'$1' cannot be extracted via ex" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

#complete -f -X '*.@(tar|xz|gz|bz2|tbz|tgz|rar|zip|Z|7z)' ex
_ex() {
  local cmd="${1##*/}"
  local word=${COMP_WORDS[COMP_CWORD]}
  #local line=${COMP_LINE}
  local xpat='!*.@(tar|tar.xz|tar.bz2|tar.gz|tbz|tgz|rar|zip|Z|7z|xz)'

  COMPREPLY=($(compgen -f -X "$xpat" -- "${word}"))
}

complete -F _ex ex

# url: http://stackoverflow.com/a/38153758/69938
# Universal Bash parameter parsing
# Parse equals separated params into named local variables
# Standalone named parameter value will equal param name (--force creates variable $force=="force")
# Parses multi-valued named params into array (--path=path1 --path=path2 creates ${path[*]} array)
# Parses un-named params into ${ARGV[*]} array
# @author Oleksii Chekulaiev
# @version v1.1 (Jul-14-2016)
# shellcheck disable=SC1001
parse_params() {
  local existing_named
  local ARGV=()
  local _key
  local _val
  echo "local ARGV=(); "
  while [[ "$1" != "" ]]; do
    # If equals delimited named parameter
    if [[ "$1" =~ ^..*=..* ]]; then
      # key is part before first =
      _key=$(echo "$1" | cut -d = -f 1)
      # val is everything after key and = (protect from param==value error)
      _val=${1/$_key=/}
      # remove dashes from key name
      _key=${_key//\-/}
      # search for existing parameter name
      if (echo "$existing_named" | grep "\b$_key\b" >/dev/null); then
        # if name already exists then it's a multi-value named parameter
        # re-declare it as an array if needed
        if ! (declare -p _key 2>/dev/null | grep -q 'declare \-a'); then
          echo "$_key=(\"\$$_key\");"
        fi
        # append new value
        echo "$_key+=('$_val');"
      else
        # single-value named parameter
        echo "local $_key=\"$_val\";"
        existing_named=" $_key"
      fi
      # If standalone named parameter
    elif [[ "$1" =~ ^\-. ]]; then
      # remove dashes
      local _key=${1//\-/}
      echo "local $_key=\"$_key\";"
      # non-named parameter
    else
      echo "ARGV+=('$1');"
    fi
    shift
  done
}

# shellcheck disable=SC2154
# shellcheck disable=SC2046
show_usage() {
  eval $(parse_params "$@")
  # --
  echo "ARGV[0]: ${ARGV[0]}"
  echo "ARGV[1]: ${ARGV[1]}"
  echo "\$anyparam: $anyparam"
  echo "\$k: $k"
  echo "\${multivalue[0]}: ${multivalue[0]}"
  echo "\${multivalue[1]}: ${multivalue[1]}"
  [[ "$force" == "force" ]] && echo "\$force is set so let the force be with you"
}

run_show_usage() {
  cmd='show_usage "param 1" --anyparam="my value" param2 k=5 --force --multi-value=test1 --multi-value=test2'
  echo "=> ${cmd}"
  eval "${cmd}"
}
