#!/bin/bash

if [[ $# -lt 1 ]]; then
    echo 'Use arguments: --user dcai --pass secret'
    exit
fi
## START Parse arguments
POSITIONAL=()
while [[ $# -gt 0 ]]; do
    key="$1"

    case $key in
        -u | --user)
            DBUSER="$2"
            shift
            shift
            ;;
        -P | --pass)
            DBPASS="$2"
            shift
            shift
            ;;
        *)                     # unknown option
            POSITIONAL+=("$1") # save it in an array for later
            shift              # past argument
            ;;
    esac
done
set -- "${POSITIONAL[@]}" # restore positional parameters
## END Parse arguments

if [[ $# -lt 2 ]]; then
    echo 'Error: please provide source db and target db names.'
    exit
fi

DBSRC=$1
TARGETDB=$2
TMPDIR=/tmp
SQLFILE=${TMPDIR}/$DBSRC.sql

# Detect paths
MYSQL=$(which mysql)
MYSQLDUMP=$(which mysqldump)
MYSQLADMIN=$(which mysqladmin)
AWK=$(which awk)
GREP=$(which grep)

echo "Backing up '${DBSRC}'"
$MYSQLDUMP -u $DBUSER -p$DBPASS --opt $DBSRC >${SQLFILE}
echo "Drop db '${TARGETDB}'"
$MYSQLADMIN -u $DBUSER -p$DBPASS -f drop $TARGETDB &>/dev/null
echo "Create db '${TARGETDB}'"
$MYSQLADMIN -u $DBUSER -p$DBPASS create $TARGETDB
echo "Restore DB"
$MYSQL -u $DBUSER -p$DBPASS $TARGETDB <${SQLFILE}
