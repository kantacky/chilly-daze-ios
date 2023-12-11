#!/bin/sh

defaults write com.apple.dt.Xcode IDESkipMacroFingerprintValidation -bool YES
mkdir /Volumes/workspace/repository/ChillyDaze/Sources/ChillyDaze/Resources
echo $GOOGLE_SERVICE_INFO > /Volumes/workspace/repository/ChillyDaze/Sources/ChillyDaze/Resources/GoogleService-Info.plist

