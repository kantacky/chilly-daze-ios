#!/bin/sh

defaults write com.apple.dt.Xcode IDESkipMacroFingerprintValidation -bool YES
mkdir ../ChillyDaze/Sources/ChillyDaze/Resources
echo $GOOGLE_SERVICE_INFO > ../ChillyDaze/Sources/ChillyDaze/Resources/GoogleService-Info.plist

