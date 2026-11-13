# Tugas 2 — Modul Hitung Nilai

## Hasil Keluaran Program

```
Mata Kuliah: Pemrograman Aplikasi Bergerak
---------------------------------
Tugas | Bobot: 30 | Skor: 28
Praktikum | Bobot: 25 | Skor: 24
Kuis | Bobot: 10 | Skor: 9
UTS | Bobot: 15 | Skor: 13
UAS | Bobot: 20 | Skor: 17
---------------------------------
Rata-rata skor: 18.20
Predikat akhir: Perlu perbaikan
```


## Refleksi (3 kalimat)

Sintaks yang paling sering saya salah pakai adalah perbedaan antara `int` dan `double`, terutama waktu melakukan pembagian karena Dart otomatis mengembalikan `double` walau kedua operand bertipe `int`. 
Saya juga sempat lupa melakukan casting eksplisit (`as int`) saat mengambil nilai dari `Map<String, Object>`, karena tipe `Object` tidak otomatis dikenali sebagai `int` oleh compiler. 
Kesalahan ini terjadi karena saya masih terbiasa dengan bahasa yang melakukan konversi tipe secara implisit, sedangkan Dart bersifat lebih ketat soal tipe data.
