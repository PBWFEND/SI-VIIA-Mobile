# Tugas 11 — Integrasi Fitur Perangkat (PresenGo)

- **Nama:** Amelia Putri Latifah
- **NIM:** 230660221101
- **Kelas:** SI-VIIA

## Dependency
- `image_picker: ^1.1.2` pada `pubspec.yaml`

## Konfigurasi Permission & Batasan Platform
- Pada target web (`Chrome`), pemilihan gambar melalui `ImagePicker` menggunakan pemilih berkas/kamera browser; izin kamera bergantung pada pengaturan izin situs di browser.
- Untuk target Android/iOS, ikuti panduan `image_picker` (misalnya konfigurasi izin kamera/penyimpanan bila diperlukan) dan uji pada perangkat/emulator target.

## Cara Menjalankan
```powershell
flutter pub get
flutter analyze
flutter run -d chrome