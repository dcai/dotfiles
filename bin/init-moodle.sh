#!/bin/bash

# brew install virtualenv
# brew install postgresql@12
# brew link postgresql@12
mkdir -p ~/moodles/www
mkdir -p ~/.moodle-sdk/
cd ~/moodles/
virtualenv venv -p $(which python3)

source ./venv/bin/activate
pip install psycopg2-binary
pip install moodle-sdk

ln -s ~/Dropbox/etc/mdk-config.json ~/.moodle-sdk/config.json

# curl https://selenium-release.storage.googleapis.com/3.141/selenium-server-standalone-3.141.59.jar -o ~/.moodle-sdk/selenium.jar

DATA="$HOME/.local/var/postgres12"
mkdir -p $DATA
initdb --encoding=UTF8 --auth=trust --username=postgres -D "$DATA"
