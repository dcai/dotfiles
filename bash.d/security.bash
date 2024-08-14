# GPGAGENTINFOFILE="$HOME/.gpg-agent-info"
# [ -f "$GPGAGENTINFOFILE" ] && source "$GPGAGENTINFOFILE"
#
# if [ -S "${GPG_AGENT_INFO%%:*}" ]; then
# export GPG_AGENT_INFO
# else
# if type "gpg-agent" &>/dev/null; then
# eval $( gpg-agent -q --daemon --default-cache-ttl 1800 --allow-preset-passphrase --log-file /tmp/gpg-agent.log )
# fi
# fi

des-encrypt() {
  if [[ -z $1 ]]; then
    echo "Filename is required"
    return 1
  fi
  OUTFILE="$1.des3"

  openssl des3 -in "$1" -out "$OUTFILE"
  echo "Encrypted file: $OUTFILE"
}

des-decrypt() {
  if [[ -z $1 ]]; then
    echo "Filename is required"
    return 1
  fi
  OUTFILE="$1.descrypted"
  openssl des3 -d -in "$1" -out "$OUTFILE"
  echo "Decrypted file: $OUTFILE"
}

aes-encrypt() {
  if [[ -z $1 ]]; then
    echo "Filename is required"
    return 1
  fi
  OUTFILE="$1.aes"
  openssl aes-256-cbc -in "$1" -out "$OUTFILE"
  echo "Encrypted file: $OUTFILE"
}

aes-decrypt() {
  if [[ -z $1 ]]; then
    echo "Filename is required"
    return 1
  fi
  OUTFILE="$1.decrypted"
  openssl aes-256-cbc -d -in "$1" -out "$1.decrypted"
  echo "Decrypted file: $OUTFILE"
}

gpg-encrypt() {
  if [[ -z $1 ]]; then
    echo "Plaintext required."
    return 1
  fi
  if [[ -z $2 ]]; then
    USERID=""
  else
    USERID=" -r $2 "
  fi
  # use public key, so passphrase not needed
  echo "$1" | gpg $USERID --armor -q --encrypt
}

gpg-decrypt() {
  if [[ -z $1 ]]; then
    echo "Secret message required."
    return 1
  fi
  echo "$1" | gpg -q --use-agent -d
}

gpg-encrypt-file() {
  if [[ -z $1 ]]; then
    echo "Filename required."
    return 1
  fi
  if [[ -z $2 ]]; then
    USERID=""
  else
    USERID=" -r $2 "
  fi
  OUTFILE="$1.gpg"
  # use public key, so passphrase not needed
  gpg -a -q --batch --no-tty --yes $USERID -o "$OUTFILE" -e $1
  echo "Encrypted file: $OUTFILE"
}

gpg-decrypt-file() {
  if [[ -z $1 ]]; then
    echo "Encrypted file required."
    return 1
  fi
  OUTFILE=$1.decrypted

  gpg -q --yes --batch --no-tty --use-agent -o "$OUTFILE" -d $1
  echo "Decrypted file: $OUTFILE"
}
