#!/bin/bash

# source "$HOME/.bash.d/mysqlrc"
EXPECTED_ARGS=2
E_BADARGS=65

if [ $# -ne $EXPECTED_ARGS ]; then
    FILENAME=$(basename $0)
    echo "Usage: ${FILENAME} {DBNAME} {DBUSER}"
    exit $E_BADARGS
fi

DBNAME=${1}
DBUSER=${2}

SQL=()
SQL+="CREATE DATABASE IF NOT EXISTS ${DBNAME} default CHARACTER set utf8 default COLLATE utf8_general_ci;"
SQL+="GRANT ALL PRIVILEGES ON ${DBNAME}.* TO ${DBUSER}@localhost;"
SQL+="FLUSH PRIVILEGES;"

QUERIES="${SQL[@]}"

echo $QUERIES
read -p "Execute queries? " -n 1 -r
echo # print a new line

if [[ $REPLY != 'y' ]]; then
    exit
fi

mysql -e "$SQL"
