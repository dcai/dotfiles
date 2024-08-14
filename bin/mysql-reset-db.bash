#!/bin/bash

if [ $# -ne 1 ]; then
    FILENAME=$(basename $0)
    echo "Usage: ${FILENAME} {DBNAME}"
    exit 1
fi

source "$HOME/.bash.d/mysqlrc"
DBNAME=$1

# Detect paths
AWK=$(which awk)
GREP=$(which grep)

TABLES=$($MYSQL $DBNAME -e 'show tables' | $AWK '{ print $1}' | $GREP -v '^Tables')

echo $TABLES
read -p "Are you sure deleting all tables? " -n 1 -r
echo # print a new line

if [[ $REPLY != 'y' ]]; then
    exit
fi

for t in $TABLES; do
    echo "Deleting $t table from $DBNAME database..."
    $MYSQL $DBNAME -e "drop table $t"
done
