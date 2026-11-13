# Tugas 7: MVP Awal dengan Data Lokal
**Nama**: Amelia Putri Latifah  
**NIM**: 230660221101  
**Domain**: Sistem Absensi Organisasi (PresenGo)

## Deskripsi Tugas
Repositori ini memuat implementasi *Minimum Viable Product* (MVP) awal dengan sistem manajemen data lokal untuk aplikasi PresenGo. Implementasi meliputi pembuatan model data (`DataKegiatan`), penggunaan `StatefulWidget`, serta pelaksanaan operasi *Create, Read, Update, Delete* (CRUD) lokal secara *in-memory* di mana data pada `State` dikelola menggunakan perintah `setState` tanpa paket tambahan eksternal.

## Refleksi
Bagian yang paling sulit dipertahankan konsistensinya adalah mengelola sinkronisasi antara operasi `Update/Delete` dengan struktur Model Data awal. Saat mengimplementasikan fungsi ubah status dan penghapusan, saya terkadang tergoda menggunakan `index` List sebagai acuan utama yang ternyata menimbulkan kerentanan saat urutan data berubah. Memaksa diri untuk mengacu pada metode `indexWhere` berbasis ID (*millisecondsSinceEpoch*) sesuai rancangan kunci data memerlukan ketelitian ekstra agar tidak menimbulkan *error* saat *runtime*.

## Deklarasi Penggunaan AI
Deklarasi penggunaan AI: Gemini — mengonstruksi alur `async-await` pada eksekusi dialog konfirmasi penghapusan jadwal (`AlertDialog`) agar operasi pengapusan (*Delete*) hanya tereksekusi jika nilai balikan (*return value*) dari modal dipastikan benar (`true`); hasilnya dirumuskan ulang oleh penulis.