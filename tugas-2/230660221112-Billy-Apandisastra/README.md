# Tugas 2 — Modul Hitung Nilai

## Identitas

- **Nama:** Billy Apandisastra
- **NIM:** 230660221112
- **Mata Kuliah:** Pemrograman Aplikasi Bergerak
- **Materi:** Dasar Pemrograman Dart
- **Pertemuan:** 2

## Deskripsi Program

Program ini dibuat menggunakan bahasa Dart untuk menghitung nilai akhir mata kuliah berdasarkan lima komponen penilaian, yaitu Tugas, Kuis, Praktikum, UTS, dan UAS.

Program menggunakan List dan Map untuk menyimpan data penilaian. Fungsi hitungRataRata() menghitung nilai akhir berdasarkan bobot setiap komponen, sedangkan fungsi predikat() menentukan predikat berdasarkan rentang nilai.

## Aturan Predikat

| Rentang Nilai | Predikat |
|---|---|
| 86–100 | A |
| 76–kurang dari 86 | B |
| 61–kurang dari 76 | C |
| Kurang dari 61 | Perlu perbaikan |

## Hasil Pengujian

```text
Mata Kuliah: Pemrograman Aplikasi Bergerak

Daftar Komponen Penilaian:
- Tugas: Bobot 20%, Skor 85
- Kuis: Bobot 15%, Skor 80
- Praktikum: Bobot 25%, Skor 90
- UTS: Bobot 20%, Skor 78
- UAS: Bobot 20%, Skor 88

Total bobot: 100%
Nilai akhir: 84.70
Predikat: B
```

## Refleksi

Melalui tugas ini, saya mempelajari penggunaan List dan Map untuk menyimpan data komponen penilaian dalam Dart. Saya juga memahami cara membuat fungsi untuk menghitung rata-rata tertimbang dan menentukan predikat berdasarkan nilai akhir. Tugas ini membantu saya memahami penggunaan variabel, perulangan, percabangan, dan fungsi dalam pemrograman Dart.