#!/bin/bash

# if [[ $# -lt 1 ]]; then
#   echo 'Use arguments: macos-tweak.sh {hostname}'
#   exit 1
# fi

IAM=$(whoami)

hint() {
    echo "=> $1"
}

# ~/.osx — http://mths.be/osx

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until `.osx` has finished
# while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

hint "never sleep"
sudo systemsetup -setcomputersleep Never

# Disable the sound effects on boot
sudo nvram SystemAudioVolume=" "

###############################################################################
# General UI/UX                                                               #
###############################################################################

HOSTNAME=
if [ ! -z $1 ]; then
    HOSTNAME=$1
    hint "Set computer name (as done via System Settings →  General →  About)"
    # computer name you see in finder
    sudo scutil --set ComputerName "${HOSTNAME}"
    # fully qualified hostname
    sudo scutil --set HostName "${HOSTNAME}.local"
    # bonjour hostname
    sudo scutil --set LocalHostName "${HOSTNAME}"
    sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "${HOSTNAME}"
    sudo dscacheutil -flushcache
fi

sudo chsh -s /opt/homebrew/bin/fish $IAM

hint "git: remove osxkeychain"
git config --system --unset credential.helper

hint "always show scroll bar"
defaults write NSGlobalDomain AppleShowScrollBars -string Always

#hint "Menu bar: disable transparency"
#defaults write NSGlobalDomain AppleEnableMenuBarTransparency -bool false

#hint "Menu bar: show remaining battery time (on pre-10.8); hide percentage"
#defaults write com.apple.menuextra.battery ShowPercent -string "YES"
#defaults write com.apple.menuextra.battery ShowTime -string "YES"

#hint "Menu bar: hide the useless Time Machine and Volume icons"
#defaults write com.apple.systemuiserver menuExtras -array "/System/Library/CoreServices/Menu Extras/Bluetooth.menu" "/System/Library/CoreServices/Menu Extras/AirPort.menu" "/System/Library/CoreServices/Menu Extras/Battery.menu" "/System/Library/CoreServices/Menu Extras/Clock.menu"

# hint "Always show scrollbars"
# defaults write NSGlobalDomain AppleShowScrollBars -string "Always"

#hint "Disable smooth scrolling"
## (Uncomment if you’re on an older Mac that messes up the animation)
#defaults write NSGlobalDomain NSScrollAnimationEnabled -bool false

#hint "Disable opening and closing window animations"
#defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false

#hint "Increase window resize speed for Cocoa applications"
#defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

hint "Expand save panel by default"
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

#hint "Expand print panel by default"
# defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
# defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

hint "Save to disk (not to iCloud) by default"
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

#hint "Automatically quit printer app once the print jobs complete"
#defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

hint 'Disable the "Are you sure you want to open this application?" dialog'
defaults write com.apple.LaunchServices LSQuarantine -bool false

hint "Display ASCII control characters using caret notation in standard text views"
# Try e.g. `cd /tmp; unidecode "\x{0000}" > cc.txt; open -e cc.txt`
defaults write NSGlobalDomain NSTextShowsControlCharacters -bool true

#hint "Disable Resume system-wide"
#defaults write NSGlobalDomain NSQuitAlwaysKeepsWindows -bool false

#hint "Disable automatic termination of inactive apps"
#defaults write NSGlobalDomain NSDisableAutomaticTermination -bool true

#hint "Disable the crash reporter"
#defaults write com.apple.CrashReporter DialogType -string "none"

hint "Set Help Viewer windows to non-floating mode"
defaults write com.apple.helpviewer DevMode -bool true

# Reveal IP address, hostname, OS version, etc. when clicking the clock
# in the login window
#sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

# Disable Notification Center and remove the menu bar icon
# launchctl unload -w /System/Library/LaunchAgents/com.apple.notificationcenterui.plist 2> /dev/null

# Disable automatic capitalization as it’s annoying when typing code
# defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

# Disable smart dashes as they’re annoying when typing code
# defaults write NSGlobalDomain NSAutomaticDashSubstitutionEnabled -bool false

# Disable automatic period substitution as it’s annoying when typing code
# defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

# Disable smart quotes as they’re annoying when typing code
# defaults write NSGlobalDomain NSAutomaticQuoteSubstitutionEnabled -bool false

# Disable auto-correct
# defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

###############################################################################
# Energy saving                                                               #
###############################################################################

hint "Enable lid wakeup"
sudo pmset -a lidwake 1

#hint "Restart automatically if the computer freezes"
#systemsetup -setrestartfreeze on

# Sleep the display after 15 minutes
# sudo pmset -a displaysleep 15

# Disable machine sleep while charging
# sudo pmset -c sleep 0

# Set machine sleep to 5 minutes on battery
# sudo pmset -b sleep 5

# Set standby delay to 24 hours (default is 1 hour)
# sudo pmset -a standbydelay 86400

#hint "Never go into computer sleep mode"
#systemsetup -setcomputersleep Off > /dev/null

# Hibernation mode
# 0: Disable hibernation (speeds up entering sleep mode)
# 3: Copy RAM to disk so the system state can still be restored in case of a
#    power failure.
# sudo pmset -a hibernatemode 0

# Remove the sleep image file to save disk space
# sudo rm /private/var/vm/sleepimage
# Create a zero-byte file instead…
# sudo touch /private/var/vm/sleepimage
# …and make sure it can’t be rewritten
# sudo chflags uchg /private/var/vm/sleepimage

#hint "Check for software updates daily, not just once per week"
#defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

###############################################################################
# Trackpad, mouse, keyboard, Bluetooth accessories, and input                 #
###############################################################################

hint "启用自然码双拼"
defaults write com.apple.inputmethod.CoreChineseEngineFramework shuangpinLayout 5

# Trackpad: enable tap to click for this user and for the login screen
hint "Trackpad: Enable tap to click (Trackpad)"
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

hint "Enable {tap-and-a-half} to drag."
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Dragging -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad DragLock -bool true
defaults write com.apple.AppleMultitouchTrackpad Dragging -bool true
defaults write com.apple.AppleMultitouchTrackpad DragLock -bool true

hint "Trackpad: Map bottom right Trackpad corner to right-click"
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick -int 2
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true
defaults -currentHost write NSGlobalDomain com.apple.trackpad.trackpadCornerClickBehavior -int 1
defaults -currentHost write NSGlobalDomain com.apple.trackpad.enableSecondaryClick -bool true

hint "Trackpad: swipe between pages with three fingers"
defaults write NSGlobalDomain AppleEnableSwipeNavigateWithScrolls -bool true
defaults -currentHost write NSGlobalDomain com.apple.trackpad.threeFingerHorizSwipeGesture -int 1
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerHorizSwipeGesture -int 1

#hint "Enable “natural” (Lion-style) scrolling"
#defaults write NSGlobalDomain com.apple.swipescrolldirection -bool true

#hint "Increase sound quality for Bluetooth headphones/headsets"
#defaults write com.apple.BluetoothAudioAgent "Apple Bitpool Min (editable)" -int 40

hint "Enable full keyboard access for all controls (e.g. enable Tab in modal dialogs)"
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

# TODO: avoid GUI password prompt somehow (http://apple.stackexchange.com/q/60476/4408)
#sudo osascript -e 'tell application "System Events" to set UI elements enabled to true'

# hint "Use scroll gesture with the Ctrl (^) modifier key to zoom"
# defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true
# defaults write com.apple.universalaccess HIDScrollZoomModifierMask -int 262144

# hint "Follow the keyboard focus while zoomed in"
# defaults write com.apple.universalaccess closeViewZoomFollowsFocus -bool true

hint "Disable press-and-hold for keys in favor of key repeat"
defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false

hint "Set a blazingly fast keyboard repeat rate, must logout"
defaults write NSGlobalDomain KeyRepeat -int 2

hint "Set a shorter Delay until key repeat, must logout"
defaults write NSGlobalDomain InitialKeyRepeat -int 15

hint "Automatically illuminate built-in MacBook keyboard in low light"
defaults write com.apple.BezelServices kDim -bool true

hint "Turn off keyboard illumination when computer is not used for 5 minutes"
defaults write com.apple.BezelServices kDimTime -int 300

#hint "Set language and text formats"
# Note: if you’re in the US, replace `EUR` with `USD`, `Centimeters` with
# `Inches`, and `true` with `false`.
#defaults write NSGlobalDomain AppleLanguages -array "en" "au"
#defaults write NSGlobalDomain AppleLocale -string "en_AU@currency=AUD"
#defaults write NSGlobalDomain AppleMeasurementUnits -string "Centimeters"
#defaults write NSGlobalDomain AppleMetricUnits -bool true

#hint "Set the timezone; see `systemsetup -listtimezones` for other values"
#systemsetup -settimezone "Australia/Sydney" > /dev/null

#hint "Disable auto-correct"
#defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

###############################################################################
# Screen                                                                      #
###############################################################################
hint "Require password immediately after sleep or screen saver begins"
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

hint "Save screenshots to the desktop"
defaults write com.apple.screencapture location -string "$HOME/Dropbox/Screenshots"

hint "Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)"
defaults write com.apple.screencapture type -string "png"

#hint "Disable shadow in screenshots"
#defaults write com.apple.screencapture disable-shadow -bool true

hint "Enable subpixel font rendering on non-Apple LCDs"
defaults write NSGlobalDomain AppleFontSmoothing -int 2

#hint "Enable HiDPI display modes (requires restart)"
#sudo defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool true

###############################################################################
# Finder                                                                      #
###############################################################################

hint "Finder: keep folders on top"
defaults write com.apple.finder _FXSortFoldersFirst -bool true
defaults write com.apple.finder _FXSortFoldersFirstOnDesktop -bool true

#hint "Finder: Allow quitting Finder via ⌘ + Q; doing so will also hide desktop icons"
#defaults write com.apple.finder QuitMenuItem -bool true

hint "Finder: disable window animations and Get Info animations"
defaults write com.apple.finder DisableAllAnimations -bool true

# Set Downloads as the default location for new Finder windows
# For other paths, use `PfLo` and `file:///full/path/here/`
defaults write com.apple.finder NewWindowTarget -string "PfDe"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/Downloads/"
defaults write com.apple.finder NSNavLastRootDirectory -string "~/Downloads"

hint "Finder: Show icons for drives, servers, removable media on the desktop"
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

#hint "Finder: show hidden files by default"
#defaults write com.apple.finder AppleShowAllFiles -bool true

hint "Finder: Show all filename extensions in Finder"
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

hint "Finder: Use current directory as default search scope in Finder"
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

hint "Finder: Show Path bar in Finder"
defaults write com.apple.finder ShowPathbar -bool true

hint "Finder: Show Status bar in Finder"
defaults write com.apple.finder ShowStatusBar -bool true

hint "Finder: allow text selection in Quick Look"
defaults write com.apple.finder QLEnableTextSelection -bool true

hint "Finder: Display full POSIX path as Finder window title"
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

hint "Finder: Disable the warning when changing a file extension"
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

hint "Finder: Avoid creating .DS_Store files on network volumes"
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

hint "Finder: Disable disk image verification"
defaults write com.apple.frameworks.diskimages skip-verify -bool true
defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true

hint "Finder: Automatically open a new Finder window when a volume is mounted"
defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true

finderplist=~/Library/Preferences/com.apple.finder.plist
hint "Finder: Show item info below desktop icons"
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:showItemInfo true" $finderplist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:showItemInfo true" $finderplist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:showItemInfo true" $finderplist

hint "Finder: Show item info to the right of the icons on the desktop"
/usr/libexec/PlistBuddy -c "Set DesktopViewSettings:IconViewSettings:labelOnBottom false" $finderplist

hint "Enable snap-to-grid for icons on the desktop and in other icon views"
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:arrangeBy grid" $finderplist
## The FK_StandardViewSettings settings are used by FinderKit and file dialogs.
## They are not changed when you press the "Use as Defaults" button from Finder's view options.
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy grid" $finderplist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy grid" $finderplist

hint "Increase grid spacing for icons on the desktop and in other icon views"
/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:gridSpacing 100" $finderplist
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:gridSpacing 100" $finderplist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:gridSpacing 100" $finderplist
/usr/libexec/PlistBuddy -c "Set :FK_DefaultIconViewSettings:gridSpacing 100" $finderplist

#hint "Increase the size of icons on the desktop and in other icon views"
#/usr/libexec/PlistBuddy -c "Set :DesktopViewSettings:IconViewSettings:iconSize 80" $finderplist
#/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:iconSize 80" $finderplist
#/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:iconSize 80" $finderplist
/usr/libexec/PlistBuddy -c 'set FK_DefaultIconViewSettings:iconSize 80' $finderplist

# Arrange by name for icons on the desktop and in other icon views
/usr/libexec/PlistBuddy -c "Set :FK_StandardViewSettings:IconViewSettings:arrangeBy name" $finderplist
/usr/libexec/PlistBuddy -c "Set :FK_DefaultIconViewSettings:arrangeBy name" $finderplist
/usr/libexec/PlistBuddy -c "Set :StandardViewSettings:IconViewSettings:arrangeBy name" $finderplist

hint "Use list view in all Finder windows by default"
# Four-letter codes for the other view modes: `icnv`, `clmv`, `Flwv`
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

hint "Enable the warning before emptying the Trash"
defaults write com.apple.finder WarnOnEmptyTrash -bool true

#hint "Empty Trash securely by default"
#defaults write com.apple.finder EmptyTrashSecurely -bool true

hint "Enable AirDrop over Ethernet and on unsupported Macs running Lion"
defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true

#hint "Enable AirDrop for all interfaces"
#defaults write com.apple.NetworkBrowser BrowseAllInterfaces 1

hint "Show the ~/Library folder"
chflags nohidden ~/Library

#hint "Remove Dropbox’s green checkmark icons in Finder"
#file=/Applications/Dropbox.app/Contents/Resources/check.icns
#[ -e "$file" ] && mv -f "$file" "$file.bak"
#unset file

###############################################################################
# Dock & hot corners                                                          #
###############################################################################

hint "Enable highlight hover effect for the grid view of a stack (Dock)"
defaults write com.apple.dock mouse-over-hilte-stack -bool true

hint "Set the icon size of Dock items to 64 pixels"
defaults write com.apple.dock tilesize -int 64

hint "Enable spring loading for all Dock items"
defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true

hint "Show indicator lights for open applications in the Dock"
defaults write com.apple.dock show-process-indicators -bool true

# Wipe all (default) app icons from the Dock
# This is only really useful when setting up a new Mac, or if you don’t use
# the Dock to launch apps.
#defaults write com.apple.dock persistent-apps -array

#hint "Don’t animate opening applications from the Dock"
#defaults write com.apple.dock launchanim -bool false

#hint "Speed up Mission Control animations"
#defaults write com.apple.dock expose-animation-duration -float 0.1

#hint "Don’t group windows by application in Mission Control"
# (i.e. use the old Exposé behavior instead)
#defaults write com.apple.dock expose-group-by-app -bool false

hint "Don’t show Dashboard as a Space"
defaults write com.apple.dock dashboard-in-overlay -bool true

#hint "Remove the auto-hiding Dock delay"
#defaults write com.apple.Dock autohide-delay -float 0

#hint "Remove the animation when hiding/showing the Dock"
#defaults write com.apple.dock autohide-time-modifier -float 0

#hint "Enable the 2D Dock"
#defaults write com.apple.dock no-glass -bool true

hint "Automatically hide and show the Dock"
defaults write com.apple.dock autohide -bool true

hint "Make Dock icons of hidden applications translucent"
defaults write com.apple.dock showhidden -bool true

#hint "Add iOS Simulator to Launchpad"
#ln -s /Applications/Xcode.app/Contents/Applications/iPhone\ Simulator.app /Applications/iOS\ Simulator.app

#hint "Add a spacer to the left side of the Dock (where the applications are)"
#defaults write com.apple.dock persistent-apps -array-add '{tile-data={}; tile-type="spacer-tile";}'
#hint "Add a spacer to the right side of the Dock (where the Trash is)"
#defaults write com.apple.dock persistent-others -array-add '{tile-data={}; tile-type="spacer-tile";}'

# Hot corners
# Possible values:
#  0: no-op
#  2: Mission Control
#  3: Show application windows
#  4: Desktop
#  5: Start screen saver
#  6: Disable screen saver
#  7: Dashboard
# 10: Put display to sleep
# 11: Launchpad
#hint "Top left screen corner → Mission Control"
#defaults write com.apple.dock wvous-tl-corner -int 2
#defaults write com.apple.dock wvous-tl-modifier -int 0
#hint "Top right screen corner → Desktop"
#defaults write com.apple.dock wvous-tr-corner -int 4
#defaults write com.apple.dock wvous-tr-modifier -int 0
#hint "Bottom left screen corner → Start screen saver"
#defaults write com.apple.dock wvous-bl-corner -int 5
#defaults write com.apple.dock wvous-bl-modifier -int 0

###############################################################################
# Safari & WebKit                                                             #
###############################################################################

hint "Set Safari’s home page to about:blank for faster loading"
defaults write com.apple.Safari HomePage -string "about:blank"

hint "Prevent Safari from opening ‘safe’ files automatically after downloading"
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false

#hint "Allow hitting the Backspace key to go to the previous page in history"
#defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2BackspaceKeyNavigationEnabled -bool true

hint "Safari: show bookmarks bar"
defaults write com.apple.Safari ShowFavoritesBar -bool true

hint "Disable Safari’s thumbnail cache for History and Top Sites"
defaults write com.apple.Safari DebugSnapshotsUpdatePolicy -int 2

hint "Safari: show full url"
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true

hint "Safari: don't save password"
defaults write com.apple.Safari AutoFillPasswords -bool false

hint "Enable Safari’s debug menu"
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

hint "Make Safari’s search banners default to Contains instead of Starts With"
defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly -bool false

hint "Remove useless icons from Safari’s bookmarks bar"
defaults write com.apple.Safari ProxiesInBookmarksBar "()"

hint "Enable the Develop menu and the Web Inspector in Safari"
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari WebKitPreferences.developerExtrasEnabled -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true

hint "safari: empty page for new tab and window"
defaults write com.apple.Safari NewTabBehavior -int 0
defaults write com.apple.Safari NewWindowBehavior -int 0

hint "Disable the bloody auto play video in safari"
defaults write com.apple.Safari WebKitMediaPlaybackAllowsInline -bool false

hint "Add a context menu item for showing the Web Inspector in web views"
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true

###############################################################################
# Mail                                                                        #
###############################################################################

#hint "Disable send and reply animations in Mail.app"
#defaults write com.apple.mail DisableReplyAnimations -bool true
#defaults write com.apple.mail DisableSendAnimations -bool true

#hint "Copy email addresses as `foo@ex.com` instead of `Foo Bar <foo@ex.com>`"
#defaults write com.apple.mail AddressesIncludeNameOnPasteboard -bool false

#hint "Add the keyboard shortcut ⌘ + Enter to send an email in Mail.app"
#defaults write com.apple.mail NSUserKeyEquivalents -dict-add "Send" "@\\U21a9"

###############################################################################
# Time Machine                                                                #
###############################################################################

hint "Prevent TimeMachine from prompting to use new hard drives as backup"
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

hint "Disable local Time Machine backups"
# hash tmutil &>/dev/null && sudo tmutil disablelocal
hash tmutil &>/dev/null && sudo tmutil disable

###############################################################################
# Notes.app
###############################################################################

# plistpath="/Applications/Notes.app/Contents/Resources/en.lproj/DefaultFonts.plist"
# sudo /usr/libexec/PlistBuddy -c "Add ::4:FontName string Courier New" $plistpath
# sudo /usr/libexec/PlistBuddy -c "Add ::4:Size integer 14" $plistpath

###############################################################################
# Address Book, Dashboard, iCal, TextEdit, and Disk Utility                   #
###############################################################################

hint "Enable the debug menu in Address Book"
defaults write com.apple.addressbook ABShowDebugMenu -bool true

hint "Enable Dashboard dev mode (allows keeping widgets on the desktop)"
defaults write com.apple.dashboard devmode -bool true

#hint "Enable the debug menu in iCal (pre-10.8)"
#defaults write com.apple.iCal IncludeDebugMenu -bool true

hint "Use plain text mode for new TextEdit documents"
defaults write com.apple.TextEdit RichText -int 0

hint "Open and save files as UTF-8 in TextEdit"
defaults write com.apple.TextEdit PlainTextEncoding -int 4
defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4

hint "Enable the debug menu in Disk Utility"
defaults write com.apple.DiskUtility DUDebugMenuEnabled -bool true
defaults write com.apple.DiskUtility advanced-image-options -bool true

###############################################################################
# Mac App Store                                                               #
###############################################################################

hint "Enable the WebKit Developer Tools in the Mac App Store"
defaults write com.apple.appstore WebKitDeveloperExtras -bool true


# disable text replacement on macos as I use espanso
defaults write -g WebAutomaticTextReplacementEnabled -bool false

# hint "Enable Debug Menu in the Mac App Store"
# defaults write com.apple.appstore ShowDebugMenu -bool true

###############################################################################
# disable crash report
###############################################################################
# hint "disable crash report"
# launchctl unload -w /System/Library/LaunchAgents/com.apple.ReportCrash.plist
# sudo launchctl unload -w /System/Library/LaunchDaemons/com.apple.ReportCrash.Root.plist

#hint "Reset Launchpad"
#[ -e ~/Library/Application\ Support/Dock/*.db ] && rm ~/Library/Application\ Support/Dock/*.db

### Shortcuts
# http://best-mac-tips.com/2012/08/29/remapping-os-x-application-keyboard-shortcuts/
# https://apple.stackexchange.com/questions/123382/is-there-a-way-to-save-your-custom-keyboard-shortcuts-in-a-config-file
# defaults read com.apple.Finder NSUserKeyEquivalents;
# reset
# defaults write com.apple.Finder NSUserKeyEquivalents -dict-add "New Finder Window" nil
# defaults write com.apple.finder NSUserKeyEquivalents '{
# "New Finder Window"="@e";
# }'

###############################################################################
# Kill affected applications                                                  #
###############################################################################

# for app in "Address Book" "Calendar" "Contacts" "Dashboard" "Dock" "Finder" \
# "Mail" "Safari" "SystemUIServer" "Terminal" "iCal" "iTunes"; do
for app in "Dashboard" "Dock" "Finder" "Mail" "SystemUIServer"; do
    killall "$app" >/dev/null 2>&1
done
# killall SystemUIServer
hint "Done. Note that some of these changes require a logout/restart to take effect."
