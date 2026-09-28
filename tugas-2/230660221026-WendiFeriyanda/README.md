# Tugas 2 — Modul Hitung Nilai

## Identitas

| Keterangan    | Data                          |
| ------------- | ----------------------------- |
| Nama          | Wendi Feriyanda               |
| NIM           | 230660221026                  |
| Program Studi | Sistem Informasi              |
| Mata Kuliah   | Pemrograman Aplikasi Bergerak |

## Deskripsi

Pada tugas ini saya membuat program Dart sederhana untuk menampilkan komponen penilaian mata kuliah, menghitung rata-rata skor, dan menentukan predikat berdasarkan rata-rata tersebut. Data penilaian disimpan menggunakan `List<Map<String, Object>>` dengan lima komponen, yaitu Tugas, Praktikum, Kuis, UTS, dan UAS.

## Hasil Output

```text
Mata Kuliah: Pemrograman Aplikasi Bergerak
==========================================
Daftar Komponen Penilaian:
Tugas - Bobot: 30 - Skor: 28
Praktikum - Bobot: 25 - Skor: 23
Kuis - Bobot: 20 - Skor: 16
UTS - Bobot: 15 - Skor: 14
UAS - Bobot: 10 - Skor: 9
==========================================
Rata-rata Skor: 18.00
Predikat Akhir: A
```

## Aturan Predikat

```text
>= 17.2 → A
>= 15.2 → B
>= 12.2 → C
< 12.2  → Perlu perbaikan
```

## Refleksi

Sintaks Dart yang paling sering saya salahgunakan adalah penggunaan `Map` karena saya masih sering tertukar antara nama key dan nilai yang disimpan di dalamnya. Saya juga masih perlu lebih teliti saat mengambil data dari `Map`, terutama ketika harus menyesuaikan tipe data menggunakan `as int`. Setelah mengerjakan tugas ini saya jadi lebih memahami cara menggunakan `List`, `Map`, perulangan `for`, dan function sederhana dalam Dart.
