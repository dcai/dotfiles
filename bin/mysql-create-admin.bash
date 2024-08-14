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
SQL+="GRANT ALL PRIVILEGES ON *.* TO ${DBUSER}@'localhost' WITH GRANT OPTION;"
SQL+="GRANT RELOAD,PROCESS ON *.* TO ${DBUSER}@'localhost';"
SQL+="FLUSH PRIVILEGES;"

QUERIES="${SQL[@]}"

echo "=> ${QUERIES}"

$MYSQL -e "$SQL"
