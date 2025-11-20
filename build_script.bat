@echo off
echo ========================================
echo    TUNARUNGU AR APP BUILD SCRIPT
echo ========================================
echo.

:menu
echo Pilih platform untuk build:
echo 1. Web
echo 2. Android APK
echo 3. Android APK (Split per architecture)
echo 4. Windows
echo 5. Clean Project
echo 6. Check Flutter Doctor
echo 7. Exit
echo.
set /p choice="Masukkan pilihan (1-7): "

if "%choice%"=="1" goto web
if "%choice%"=="2" goto android
if "%choice%"=="3" goto android_split
if "%choice%"=="4" goto windows
if "%choice%"=="5" goto clean
if "%choice%"=="6" goto doctor
if "%choice%"=="7" goto exit
goto menu

:web
echo.
echo Building untuk Web...
flutter build web
if %errorlevel% equ 0 (
    echo.
    echo ✅ Web build berhasil!
    echo 📁 Output: build/web/
    echo 🌐 Deploy: Upload folder build/web/ ke web server
) else (
    echo ❌ Web build gagal!
)
pause
goto menu

:android
echo.
echo Building APK untuk Android...
flutter build apk --release
if %errorlevel% equ 0 (
    echo.
    echo ✅ Android APK build berhasil!
    echo 📁 Output: build/app/outputs/flutter-apk/app-release.apk
    echo 📱 Install: adb install build/app/outputs/flutter-apk/app-release.apk
) else (
    echo ❌ Android build gagal!
)
pause
goto menu

:android_split
echo.
echo Building APK dengan split per architecture...
flutter build apk --split-per-abi --release
if %errorlevel% equ 0 (
    echo.
    echo ✅ Android APK split build berhasil!
    echo 📁 Output: build/app/outputs/flutter-apk/
    echo 📱 Files:
    echo    - app-armeabi-v7a-release.apk (ARM 32-bit)
    echo    - app-arm64-v8a-release.apk (ARM 64-bit)
    echo    - app-x86_64-release.apk (x86 64-bit)
) else (
    echo ❌ Android split build gagal!
)
pause
goto menu

:windows
echo.
echo Building untuk Windows...
flutter build windows --release
if %errorlevel% equ 0 (
    echo.
    echo ✅ Windows build berhasil!
    echo 📁 Output: build/windows/runner/Release/
    echo 🪟 Run: build/windows/runner/Release/runner.exe
) else (
    echo ❌ Windows build gagal!
)
pause
goto menu

:clean
echo.
echo Cleaning project...
flutter clean
flutter pub get
echo ✅ Project cleaned!
pause
goto menu

:doctor
echo.
echo Checking Flutter installation...
flutter doctor
echo.
pause
goto menu

:exit
echo.
echo Terima kasih telah menggunakan build script!
pause
exit 