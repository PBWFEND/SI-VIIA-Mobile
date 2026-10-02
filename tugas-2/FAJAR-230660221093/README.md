# Tugas 2 — Modul Hitung Nilai

| | |
|:--|:--|
| **Nama** | FAJAR |
| **NIM** | 230660221093 |
| **Kelas** | SI-VIIA |

---

## 1. Keluaran Program

Mata kuliah: Pemrograman Aplikasi Bergerak

Daftar komponen penilaian:
- Tugas: bobot 30, skor 90
- Praktikum: bobot 25, skor 95
- Kuis: bobot 10, skor 85
- UTS: bobot 15, skor 78
- UAS: bobot 20, skor 92

Rata-rata skor: 88.00
Predikat akhir: A
```

## 2. Refleksi

Sintaks yang paling sering saya salah gunakan adalah casting as int pada item['skor']. Karena data disimpan sebagai Map<String, Object>, Dart menganggap nilainya bertipe Object, sehingga saya lupa menambahkan as int sebelum menjumlahkannya di dalam hitungRataRata. Akibatnya muncul error yang membingungkan karena Dart menolak operasi + pada tipe Object, padahal isinya jelas angka.
```

