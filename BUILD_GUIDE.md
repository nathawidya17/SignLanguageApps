# 🚀 Panduan Build Aplikasi Tunarungu AR

## 📋 Prerequisites (Persyaratan Awal)

### **1. Software yang Diperlukan**
- ✅ **Flutter SDK** (versi 3.8.1 atau lebih baru)
- ✅ **Dart SDK** (terinstall otomatis dengan Flutter)
- ✅ **Android Studio** atau **VS Code**
- ✅ **Git** (untuk version control)

### **2. Platform Development**
- ✅ **Android**: Android Studio + Android SDK
- ✅ **iOS**: Xcode (hanya untuk macOS)
- ✅ **Web**: Chrome browser
- ✅ **Windows**: Visual Studio dengan C++ tools

---

## 🔧 **Langkah-langkah Build**

### **Step 1: Setup Environment**
```bash
# 1. Pastikan Flutter sudah terinstall
flutter doctor

# 2. Jika ada masalah, jalankan:
flutter doctor --android-licenses
```

### **Step 2: Clone dan Setup Project**
```bash
# 1. Clone repository (jika belum)
git clone <repository-url>
cd tunarunguv2

# 2. Install dependencies
flutter pub get

# 3. Clean project (opsional, jika ada masalah)
flutter clean
flutter pub get
```

### **Step 3: Build untuk Platform yang Diinginkan**

#### **🌐 Build untuk Web**
```bash
# Build untuk development
flutter run -d chrome

# Build untuk production
flutter build web
```

#### **📱 Build untuk Android**
```bash
# 1. Pastikan device/emulator terdeteksi
flutter devices

# 2. Build untuk development
flutter run

# 3. Build APK untuk release
flutter build apk --release

# 4. Build APK dengan split per architecture (lebih kecil)
flutter build apk --split-per-abi --release
```

#### **🍎 Build untuk iOS (macOS only)**
```bash
# 1. Pastikan Xcode terinstall
flutter doctor

# 2. Build untuk development
flutter run

# 3. Build untuk release
flutter build ios --release
```

#### **🪟 Build untuk Windows**
```bash
# 1. Enable Windows support
flutter config --enable-windows-desktop

# 2. Build untuk development
flutter run -d windows

# 3. Build untuk release
flutter build windows --release
```

---

## 📦 **Output Files**

### **Web Build**
- 📁 **Location**: `build/web/`
- 📄 **Files**: HTML, CSS, JS files
- 🌐 **Deploy**: Upload ke web server

### **Android Build**
- 📁 **Location**: `build/app/outputs/flutter-apk/`
- 📄 **Files**: 
  - `app-release.apk` (full APK)
  - `app-armeabi-v7a-release.apk` (ARM 32-bit)
  - `app-arm64-v8a-release.apk` (ARM 64-bit)
  - `app-x86_64-release.apk` (x86 64-bit)

### **iOS Build**
- 📁 **Location**: `build/ios/archive/`
- 📄 **Files**: `.ipa` file untuk App Store

### **Windows Build**
- 📁 **Location**: `build/windows/runner/Release/`
- 📄 **Files**: `.exe` dan supporting files

---

## 🔍 **Troubleshooting**

### **Masalah Umum**

#### **1. Flutter Doctor Issues**
```bash
# Jalankan flutter doctor untuk melihat masalah
flutter doctor

# Fix Android licenses
flutter doctor --android-licenses

# Update Flutter
flutter upgrade
```

#### **2. Dependencies Issues**
```bash
# Clean dan reinstall dependencies
flutter clean
flutter pub get

# Update dependencies
flutter pub upgrade
```

#### **3. Build Errors**
```bash
# Clean build cache
flutter clean
flutter pub get

# Rebuild
flutter build apk --release
```

#### **4. Device Not Detected**
```bash
# List devices
flutter devices

# Restart adb (Android)
adb kill-server
adb start-server

# Restart Flutter daemon
flutter daemon --shutdown
```

---

## 📱 **Testing Build**

### **Web Testing**
```bash
# Build dan serve web
flutter build web
cd build/web
python -m http.server 8000
# Buka http://localhost:8000
```

### **Android Testing**
```bash
# Install APK ke device
flutter install

# Atau manual install
adb install build/app/outputs/flutter-apk/app-release.apk
```

### **iOS Testing**
```bash
# Install ke simulator
flutter run

# Atau buka di Xcode
open ios/Runner.xcworkspace
```

---

## 🚀 **Deployment**

### **Web Deployment**
1. **Firebase Hosting**
```bash
# Install Firebase CLI
npm install -g firebase-tools

# Login dan deploy
firebase login
firebase init hosting
firebase deploy
```

2. **Netlify**
- Upload folder `build/web/` ke Netlify
- Atau connect dengan Git repository

3. **Vercel**
- Connect repository ke Vercel
- Auto-deploy saat push

### **Android Deployment**
1. **Google Play Store**
- Upload APK ke Google Play Console
- Fill metadata dan screenshots
- Submit untuk review

2. **Direct Distribution**
- Share APK file langsung
- Upload ke file sharing service

### **iOS Deployment**
1. **App Store**
- Archive project di Xcode
- Upload ke App Store Connect
- Submit untuk review

---

## 📋 **Checklist Build**

### **Pre-Build**
- [ ] Flutter doctor passed
- [ ] Dependencies installed
- [ ] Device/emulator ready
- [ ] Code compiles without errors

### **Build Process**
- [ ] Clean project (if needed)
- [ ] Run build command
- [ ] Check for build errors
- [ ] Verify output files

### **Post-Build**
- [ ] Test on target device
- [ ] Check all features work
- [ ] Verify performance
- [ ] Prepare for distribution

---

## 🔧 **Advanced Build Options**

### **Build dengan Custom Configuration**
```bash
# Build dengan specific flavor
flutter build apk --flavor production --release

# Build dengan custom target
flutter build apk --target lib/main_prod.dart

# Build dengan specific architecture
flutter build apk --target-platform android-arm64
```

### **Performance Optimization**
```bash
# Build dengan tree shaking
flutter build apk --tree-shake-icons

# Build dengan obfuscation
flutter build apk --obfuscate --split-debug-info=build/debug-info
```

---

## 📞 **Support**

### **Jika Ada Masalah**
1. **Check Flutter Doctor**: `flutter doctor -v`
2. **Check Logs**: `flutter logs`
3. **Clean Build**: `flutter clean && flutter pub get`
4. **Update Flutter**: `flutter upgrade`

### **Useful Commands**
```bash
# Check Flutter version
flutter --version

# Check available devices
flutter devices

# Check project dependencies
flutter pub deps

# Analyze code
flutter analyze

# Run tests
flutter test
```

---

## 🎯 **Quick Start Commands**

### **Development**
```bash
flutter pub get
flutter run
```

### **Production Build**
```bash
# Web
flutter build web

# Android
flutter build apk --release

# iOS
flutter build ios --release
```

---

*Panduan ini akan membantu user untuk build aplikasi Tunarungu AR dengan mudah dan mengatasi masalah yang mungkin terjadi.* 