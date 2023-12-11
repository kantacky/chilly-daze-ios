#!/bin/sh

defaults write com.apple.dt.Xcode IDESkipMacroFingerprintValidation -bool YES
echo $GOOGLE_SERVICE_INFO > ../ChillyDaze/Sources/ChillyDaze/GoogleService-Info.plist

