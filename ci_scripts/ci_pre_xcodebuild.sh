#!/bin/sh

defaults write com.apple.dt.Xcode IDESkipMacroFingerprintValidation -bool YES
echo $(ls /Volumes/workspace/repository)
echo $GOOGLE_SERVICE_INFO > /Volumes/workspace/repository/ChillyDaze/Sources/ChillyDaze/Resources/GoogleService-Info.plist
