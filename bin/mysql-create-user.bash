#!/bin/bash

source "$HOME/.bash.d/mysqlrc"

if [ $# -ne 1 ]; then
    echo "Usage: $0 DBUSER"
    exit 230
fi

DBUSER=${1}
DBPASS=${1}

SQL=()
SQL+="CREATE USER '${DBUSER}'@'localhost' IDENTIFIED BY '${DBPASS}';"

QUERIES="${SQL[@]}"

echo "=> ${QUERIES}"

$MYSQL -e "$SQL"
