#!/bin/bash

source "$HOME/.bash.d/mysqlrc"
EXPECTED_ARGS=3
E_BADARGS=65

if [ $# -ne $EXPECTED_ARGS ]; then
    FILENAME=$(basename $0)
    echo "Usage: $0 {DBNAME} {DBUSER} {DBPASS}"
    exit $E_BADARGS
fi

DBNAME=${1}
DBUSER=${2}
DBPASS=${3}

SQL=()
SQL+="CREATE USER '${DBUSER}'@'localhost' IDENTIFIED BY '${DBPASS}';"
SQL+="CREATE DATABASE IF NOT EXISTS ${DBNAME} default CHARACTER set utf8 default COLLATE utf8_general_ci;"
SQL+="GRANT USAGE ON *.* TO ${DBUSER}@localhost IDENTIFIED BY '${DBPASS}';"
SQL+="GRANT ALL PRIVILEGES ON ${DBNAME}.* TO ${DBUSER}@localhost;"
SQL+="FLUSH PRIVILEGES;"

QUERIES="${SQL[@]}"

echo $QUERIES
read -p "Execute queries? " -n 1 -r
echo # print a new line

if [[ $REPLY != 'y' ]]; then
    exit
fi

$MYSQL -e "$SQL"
