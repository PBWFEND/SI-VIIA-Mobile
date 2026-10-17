# Tugas 5: Prototype UI/UX
**Nama**: Amelia Putri Latifah  
**NIM**: 230660221101  
**Domain Sistem**: Sistem Absensi Organisasi

## Deskripsi Tugas
Repositori ini memuat implementasi *prototype* antarmuka pengguna untuk aplikasi PresenGo, mulai dari arsitektur informasi, rancangan *wireframe low-fidelity*, catatan keputusan desain (UI/UX), hingga implementasi kode Flutter. Antarmuka dibangun menggunakan pustaka Material Design 3 dengan memanfaatkan `ThemeData` secara dinamis, sehingga komponen antarmuka dapat menyesuaikan skema warna *seed* tanpa perlu melakukan *hardcode* warna pada setiap *widget*.

## Refleksi
Bagian yang paling sulit dipertahankan konsistensinya adalah saat mengonversi coretan struktur posisi di *wireframe* menjadi susunan *widget* di Flutter yang harus mematuhi aturan hierarki `ThemeData` Material 3. Sering kali saya berekspektasi komponen *Card* atau *Chip* pada *wireframe* memiliki dimensi tertentu, namun saat diimplementasikan ke kode, warna dan batas bantalan (*padding*) bawaan dari Material 3 memaksa saya untuk merevisi catatan keputusan desain UI agar lebih selaras dengan standar tata letak sistem. Penyesuaian ini memakan waktu paling lama karena harus memastikan tidak ada warna yang diisi manual.

## Deklarasi Penggunaan AI
Deklarasi penggunaan AI: Gemini — membantu meninjau keselarasan pemanggilan skema warna dinamis dari parameter `colorScheme` Material 3 untuk implementasi pewarnaan latar belakang menggunakan logika *ternary* pada status kegiatan; hasilnya dirumuskan ulang dan diuji oleh penulis.