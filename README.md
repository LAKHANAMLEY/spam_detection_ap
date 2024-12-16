# spam_delection_app

A new Flutter project.

## Getting Started

## Flutter doctor log
'''dart

[✓] Flutter (Channel stable, 3.24.3, on macOS 14.6.1 23G93 darwin-arm64, locale
    en-IN)
    • Flutter version 3.24.3 on channel stable at /Users/rajkumar/Desktop/flutter
    • Upstream repository https://github.com/flutter/flutter.git
    • Framework revision 2663184aa7 (3 months ago), 2024-09-11 16:27:48 -0500
    • Engine revision 36335019a8
    • Dart version 3.5.3
    • DevTools version 2.37.3

[✓] Android toolchain - develop for Android devices (Android SDK version 35.0.0)
    • Android SDK at /Users/rajkumar/Library/Android/sdk
    • Platform android-35, build-tools 35.0.0
    • Java binary at: /Applications/Android
      Studio.app/Contents/jbr/Contents/Home/bin/java
    • Java version OpenJDK Runtime Environment (build 21.0.3+-79915917-b509.11)
    • All Android licenses accepted.

[✓] Xcode - develop for iOS and macOS (Xcode 15.0.1)
    • Xcode at /Applications/Xcode.app/Contents/Developer
    • Build 15A507
    • CocoaPods version 1.15.2

[✓] Chrome - develop for the web
    • Chrome at /Applications/Google Chrome.app/Contents/MacOS/Google Chrome

[✓] Android Studio (version 2024.2)
    • Android Studio at /Applications/Android Studio.app/Contents
    • Flutter plugin can be installed from:
      🔨 https://plugins.jetbrains.com/plugin/9212-flutter
    • Dart plugin can be installed from:
      🔨 https://plugins.jetbrains.com/plugin/6351-dart
    • Java version OpenJDK Runtime Environment (build 21.0.3+-79915917-b509.11)

[✓] VS Code (version 1.95.3)
    • VS Code at /Applications/Visual Studio Code.app/Contents
    • Flutter extension version 3.102.0

[✓] Connected device (4 available)
    • sdk gphone64 arm64 (mobile)     • emulator-5554         • android-arm64  •
      Android 14 (API 34) (emulator)
    • macOS (desktop)                 • macos                 • darwin-arm64   •
      macOS 14.6.1 23G93 darwin-arm64
    • Mac Designed for iPad (desktop) • mac-designed-for-ipad • darwin         •
      macOS 14.6.1 23G93 darwin-arm64
    • Chrome (web)                    • chrome                • web-javascript •
      Google Chrome 131.0.6778.86

[✓] Network resources
    • All expected network resources are available.

• No issues found!

'''

## Errors resolution
### 1.
error: resource android:attr/lStar not found.

### Solution

'''gradle

compileSdkVersion 34

dependencies {
    implementation 'androidx.core:core-ktx:1.6.0' 
}

'''