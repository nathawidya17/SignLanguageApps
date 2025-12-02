#!/bin/bash

echo "========================================"
echo "   TUNARUNGU AR APP BUILD SCRIPT"
echo "========================================"
echo

show_menu() {
    echo "Pilih platform untuk build:"
    echo "1. Web"
    echo "2. Android APK"
    echo "3. Android APK (Split per architecture)"
    echo "4. iOS (macOS only)"
    echo "5. Windows"
    echo "6. Clean Project"
    echo "7. Check Flutter Doctor"
    echo "8. Exit"
    echo
}

build_web() {
    echo
    echo "Building untuk Web..."
    flutter build web
    if [ $? -eq 0 ]; then
        echo
        echo "✅ Web build berhasil!"
        echo "📁 Output: build/web/"
        echo "🌐 Deploy: Upload folder build/web/ ke web server"
    else
        echo "❌ Web build gagal!"
    fi
}

build_android() {
    echo
    echo "Building APK untuk Android..."
    flutter build apk --release
    if [ $? -eq 0 ]; then
        echo
        echo "✅ Android APK build berhasil!"
        echo "📁 Output: build/app/outputs/flutter-apk/app-release.apk"
        echo "📱 Install: adb install build/app/outputs/flutter-apk/app-release.apk"
    else
        echo "❌ Android build gagal!"
    fi
}

build_android_split() {
    echo
    echo "Building APK dengan split per architecture..."
    flutter build apk --split-per-abi --release
    if [ $? -eq 0 ]; then
        echo
        echo "✅ Android APK split build berhasil!"
        echo "📁 Output: build/app/outputs/flutter-apk/"
        echo "📱 Files:"
        echo "   - app-armeabi-v7a-release.apk (ARM 32-bit)"
        echo "   - app-arm64-v8a-release.apk (ARM 64-bit)"
        echo "   - app-x86_64-release.apk (x86 64-bit)"
    else
        echo "❌ Android split build gagal!"
    fi
}

build_ios() {
    echo
    echo "Building untuk iOS..."
    flutter build ios --release
    if [ $? -eq 0 ]; then
        echo
        echo "✅ iOS build berhasil!"
        echo "📁 Output: build/ios/archive/"
        echo "🍎 Deploy: Upload ke App Store Connect"
    else
        echo "❌ iOS build gagal!"
    fi
}

build_windows() {
    echo
    echo "Building untuk Windows..."
    flutter build windows --release
    if [ $? -eq 0 ]; then
        echo
        echo "✅ Windows build berhasil!"
        echo "📁 Output: build/windows/runner/Release/"
        echo "🪟 Run: build/windows/runner/Release/runner.exe"
    else
        echo "❌ Windows build gagal!"
    fi
}

clean_project() {
    echo
    echo "Cleaning project..."
    flutter clean
    flutter pub get
    echo "✅ Project cleaned!"
}

check_doctor() {
    echo
    echo "Checking Flutter installation..."
    flutter doctor
    echo
}

# Main menu loop
while true; do
    show_menu
    read -p "Masukkan pilihan (1-8): " choice
    
    case $choice in
        1)
            build_web
            ;;
        2)
            build_android
            ;;
        3)
            build_android_split
            ;;
        4)
            if [[ "$OSTYPE" == "darwin"* ]]; then
                build_ios
            else
                echo "❌ iOS build hanya tersedia di macOS!"
            fi
            ;;
        5)
            build_windows
            ;;
        6)
            clean_project
            ;;
        7)
            check_doctor
            ;;
        8)
            echo
            echo "Terima kasih telah menggunakan build script!"
            exit 0
            ;;
        *)
            echo "❌ Pilihan tidak valid!"
            ;;
    esac
    
    echo
    read -p "Tekan Enter untuk melanjutkan..."
done 