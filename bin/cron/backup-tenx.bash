#!/bin/bash

ROOT="/Users/dcai/Dropbox (Personal)/Public/src"
#cd "/Users/dcai/src/news-quickstart/www/wp-content/themes/vip/"

date

#export XZ_OPT=-9
export TARBIN="/usr/local/bin/gtar -cJf"

#tar -cjf "${ROOT}/tenx.tar.bz2" --exclude="node_modules" --exclude="vendor" --exclude="dist" --exclude=".idea" "./newscorpau-tenx" &>> /tmp/backuptenx.log

cd "/Users/dcai/src/"
# truck-manifest
$TARBIN "${ROOT}/truckmanifest.tar.xz" --exclude='node_modules' --exclude='vendor' --exclude='dist' --exclude='.idea' "truck-manifest"
# tcog
$TARBIN "${ROOT}/tcog.tar.xz" --exclude="node_modules" --exclude="vendor" --exclude="dist" --exclude=".idea" "tcog"
# cfn
$TARBIN "${ROOT}/vip-cfn.tar.xz" --exclude="vendor" "vip-quickstart-cfn"
# aws-generic
$TARBIN "${ROOT}/aws-generic-cfn.tar.xz" 'aws---generic-cloudformation'
# bruce
$TARBIN "${ROOT}/bruce.tar.xz" --exclude="vendor" 'bruce'
# gonews
$TARBIN "${ROOT}/gonews.tar.xz" --exclude="vendor" 'gonews'
# kinesis log
$TARBIN "${ROOT}/kinesis-log.tar.xz" --exclude="vendor" 'kinesis-log'
# akamai ets
$TARBIN "${ROOT}/akamai-ets.tar.xz" --exclude="vendor" 'akamai-ets'
