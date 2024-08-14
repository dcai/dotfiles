#!/bin/bash

source "$HOME/.bash.d/mysqlrc"

EXPECTED_ARGS=1
E_BADARGS=65

if [ $# -ne $EXPECTED_ARGS ]; then
    FILENAME=$(basename $0)
    echo "Usage: ${FILENAME} {DBUSER}"
    exit $E_BADARGS
fi

DBNAME=${1}

SQL=()
SQL+="SHOW GRANTS FOR '${DBNAME}'@'localhost'"

QUERIES="${SQL[@]}"

$MYSQL -e "$SQL"
