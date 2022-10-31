#!/usr/bin/env bash
# Based on https://github.com/microsoft/appcenter/blob/master/sample-build-scripts/flutter/android-build/appcenter-post-clone.sh

set -e
set -x

cd ../..
git clone -b 3.3.6 https://github.com/flutter/flutter.git
export PATH=`pwd`/flutter/bin:$PATH

yes | flutter doctor --android-licenses
flutter doctor -v
flutter pub get

# if you get "Execution failed for task ':app:lintVitalRelease'." error, uncomment next two lines
#flutter build apk --debug
#flutter build apk --profile
flutter build apk --release --build-number "$APPCENTER_BUILD_ID"
flutter build appbundle --release --build-number "$APPCENTER_BUILD_ID"

# copy the APK where AppCenter will find it
ls -la build/app/outputs/apk/release/
mkdir -p android/app/build/outputs/apk/
cp build/app/outputs/apk/release/app-release.apk $_

# copy the AAB where AppCenter will find it
ls -la build/app/outputs/bundle/release/
mkdir -p android/app/build/outputs/bundle/
cp build/app/outputs/bundle/release/app-release.aab $_
