#!/bin/sh

sudo tmutil disablelocal

sudo rm -rf /.Spotlight-V100
sudo rm -rf /.MobileBackups
sudo rm -rf "/lost+found"

#sudo pmset hibernatemode 0
echo "- Deleting swapfiles"
# sudo rm -f /private/var/vm/swapfile*
# sudo rm -f /private/var/vm/sleepimage

#remove adobe stuff
#rm -rf "/Library/Application Support/Adobes/"

rm -rf /Users/dcai/Library/Containers/tv.sohu.SHPlayer
rm -rf /Users/dcai/Library/Containers/tv.pps.mac
rm -rf /Users/dcai/Library/Containers/com.netease.163music/Data/Caches

# wildcard must be outside of double quote scope
echo "- Deleting CleanMyMac2 updates"
rm -rf "/Users/dcai/Library/Application Support/CleanMyMac 2/CleanMyMac 2 2."*

echo "- Deleting iphone backup files"
rm -rf "/Users/dcai/Library/Application Support/MobileSync/Backup"

echo "- Deleting qq music"
rm -rf "/Users/dcai/Library/Application Support/QQMusicMac"

echo "- Deleting xcode stuff"
rm -rf /Users/dcai/Library/Developer/Xcode/DerivedData/
echo "- Deleting shared cache of old system"
sudo rm -rf /Library/SystemMigration/*

#rm -rf /Users/dcai/Library/Caches/Google/Chrome
#rm -rf /Users/dcai/Library/Caches/com.apple.helpd
sudo rm -rf /System/Library/Caches/com.apple.coresymbolicationd

echo "- Cleaning /var/log/"

sudo launchctl stop com.apple.syslogd
sudo launchctl stop com.apple.aslmanager

sudo rm -f /var/log/commerce.log
sudo rm -f /var/log/install.log
sudo rm -f /var/log/getsslpassphrase.log
sudo rm -f /var/log/system.log.*
sudo rm -f /var/log/coreduetd.log.*
sudo rm -f /var/log/opendirectoryd.log.*
sudo rm -f /var/log/accountpolicy.log.*
sudo rm -rf /var/log/asl
sudo rm -rf /var/log/DiagnosticMessages

sudo launchctl start com.apple.syslogd
sudo launchctl start com.apple.aslmanager
