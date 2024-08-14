# pyenv
#export PYENV_ROOT="$HOME/.pyenv"
#export VIRTUALENVDIR="${PYENV_ROOT}/plugins/pyenv-virtualenv"
#export VIRTUALENVWRAPPERDIR="${PYENV_ROOT}/plugins/pyenv-virtualenvwrapper"
#export PYENV_VIRTUALENVWRAPPER_PREFER_PYVENV="true"

# virtualenvwrapper
export WORKON_HOME="$HOME/.virtualenvs"
#export VIRTUALENVWRAPPER_PYTHON='/usr/local/bin/python3'
if type "virtualenvwrapper.sh" &>/dev/null; then
  virtualenvwrapperbinpath=$(which virtualenvwrapper_lazy.sh)
  source $virtualenvwrapperbinpath
fi

py-simple-http-server() {
  PORT=8000
  if [[ $# -ne 0 ]]; then
    PORT=$1
  fi
  python -m SimpleHTTPServer "${PORT}"
}

pip-upgrade() {
  #pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U
  pip list --outdated | sed 's/(.*//g' | xargs pip install -U
}

install-pyenv() {
  #URL="https://raw.githubusercontent.com/yyuu/pyenv-installer/master/bin/pyenv-installer"
  #curl -L "$URL" | bash
  #return

  if [[ ! -d $PYENV_ROOT ]]; then
    mkdir -p $PYENV_ROOT
    git clone git://github.com/yyuu/pyenv.git $PYENV_ROOT
  else
    cd $PYENV_ROOT
    git pull -r
  fi
  if [[ ! -d $VIRTUALENVDIR ]]; then
    mkdir -p $VIRTUALENVDIR
    git clone git://github.com/yyuu/pyenv-virtualenv.git $VIRTUALENVDIR
  else
    cd $VIRTUALENVDIR
    git pull -r
  fi
  if [[ ! -d $VIRTUALENVWRAPPERDIR ]]; then
    mkdir -p $VIRTUALENVWRAPPERDIR
    git clone git://github.com/yyuu/pyenv-virtualenvwrapper.git $VIRTUALENVWRAPPERDIR
  else
    cd $VIRTUALENVWRAPPERDIR
    git pull -r
  fi
}

# > /dev/null 2>&1 is the same as &> /dev/null
#if type "pyenv" &>/dev/null; then
#if [[ ! -d $WORKON_HOME ]]; then
#mkdir -p "$WORKON_HOME"
#fi
#eval "$(pyenv init -)"
#eval "$(pyenv virtualenv-init -)"
#eval "$(pyenv virtualenvwrapper -)"
#fi
