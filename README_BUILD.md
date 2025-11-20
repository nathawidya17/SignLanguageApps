# 🚀 Cara Build Aplikasi Tunarungu AR

## 📋 **Persyaratan**
- Flutter SDK (versi 3.8.1+)
- Android Studio atau VS Code
- Git

## ⚡ **Cara Cepat Build**

### **Windows Users**
1. Double click file `build_script.bat`
2. Pilih platform yang diinginkan (1-7)
3. Tunggu proses build selesai

### **macOS/Linux Users**
1. Buka terminal di folder project
2. Jalankan: `chmod +x build_script.sh`
3. Jalankan: `./build_script.sh`
4. Pilih platform yang diinginkan (1-8)

## 🔧 **Build Manual**

### **Web**
```bash
flutter build web
# Output: build/web/
```

### **Android APK**
```bash
flutter build apk --release
# Output: build/app/outputs/flutter-apk/app-release.apk
```

### **Android APK (Split)**
```bash
flutter build apk --split-per-abi --release
# Output: build/app/outputs/flutter-apk/
# - app-armeabi-v7a-release.apk (ARM 32-bit)
# - app-arm64-v8a-release.apk (ARM 64-bit)
# - app-x86_64-release.apk (x86 64-bit)
```

### **Windows**
```bash
flutter build windows --release
# Output: build/windows/runner/Release/
```

### **iOS (macOS only)**
```bash
flutter build ios --release
# Output: build/ios/archive/
```

## 📱 **Testing Build**

### **Web**
```bash
cd build/web
python -m http.server 8000
# Buka: http://localhost:8000
```

### **Android**
```bash
adb install build/app/outputs/flutter-apk/app-release.apk
```

### **Windows**
```bash
# Buka folder: build/windows/runner/Release/
# Double click: runner.exe
```

## 🔍 **Troubleshooting**

### **Jika Build Gagal**
1. Jalankan: `flutter doctor`
2. Jalankan: `flutter clean`
3. Jalankan: `flutter pub get`
4. Coba build lagi

### **Device Tidak Terdeteksi**
```bash
flutter devices
adb kill-server
adb start-server
```

### **Dependencies Error**
```bash
flutter pub upgrade
flutter pub get
```

## 📦 **Output Files**

| Platform | Location | File Type |
|----------|----------|-----------|
| **Web** | `build/web/` | HTML, CSS, JS |
| **Android** | `build/app/outputs/flutter-apk/` | `.apk` |
| **Windows** | `build/windows/runner/Release/` | `.exe` |
| **iOS** | `build/ios/archive/` | `.ipa` |

## 🚀 **Deployment**

### **Web**
- Upload folder `build/web/` ke web server
- Atau gunakan Firebase Hosting, Netlify, Vercel

### **Android**
- Upload APK ke Google Play Store
- Atau share file APK langsung

### **Windows**
- Share folder `build/windows/runner/Release/`
- Atau buat installer dengan tools seperti Inno Setup

## 📞 **Support**

Jika ada masalah:
1. Check `flutter doctor`
2. Clean project: `flutter clean && flutter pub get`
3. Update Flutter: `flutter upgrade`
4. Check logs: `flutter logs`

---

**🎯 Tips:**
- Gunakan script build untuk kemudahan
- Test di device target sebelum release
- Backup project sebelum build besar
- Check file size untuk optimization

---

*Build script dibuat untuk memudahkan proses build aplikasi Tunarungu AR* 