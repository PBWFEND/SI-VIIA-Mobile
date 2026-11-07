# Tugas 6: Navigasi dan Interaksi
**Nama**: Amelia Putri Latifah  
**NIM**: 230660221101  
**Domain**: Sistem Absensi Organisasi (PresenGo)

## Deskripsi Tugas
Repositori ini memuat penyelesaian Tugas 6 untuk mata kuliah Pemrograman Aplikasi Bergerak. Implementasi mencakup perancangan Navigation Flow dari IA, penggunaan Navigator (`pushNamed` dan `pop`) melalui pendefinisian rute `MaterialApp`, pengiriman data *read-only* antar layar via `arguments`, pembuatan form menggunakan `GlobalKey<FormState>`, pembersihan memori pada `dispose`, serta pemberian feedback interaksi berupa peringatan validasi dan `SnackBar`.

## Refleksi
Bagian yang paling sulit dipertahankan konsistensinya adalah menyelaraskan nama rute dan data yang dikirim antara diagram rancangan *navigation flow*, catatan keputusan, dan implementasi kode asli. Hal ini karena saat mengetik kode, saya terkadang tergoda menambah rute spontan untuk kelancaran visual tanpa merujuk kembali pada batasan Kebutuhan Fungsional (IA) yang sudah dikunci. Oleh karena itu, saya harus berulang kali mengecek ulang fungsi `pushNamed` agar hanya mengirim tipe argumen yang benar-benar tercatat pada keputusan desain, sehingga terhindar dari *error* pelemparan *null*.

## Deklarasi Penggunaan AI
Deklarasi penggunaan AI: Gemini — mengevaluasi struktur penggunaan metode *dispose()* pada *StatefulWidget* untuk menghindari *memory leak* dan merapikan visualisasi diagram Mermaid agar sesuai dengan format *flowchart TD*; hasilnya dirumuskan ulang oleh penulis.