# Tugas 10 — Integrasi Data dan Proses Bisnis

## Identitas

- **Nama:** Elangga Yudistira
- **NIM:** 230660221109
- **Kelas:** SI-VIIA
- **Aplikasi:** MoneyTrack Mahasiswa — Integrasi Data Pengajuan

## Implementasi

Aplikasi ini menggabungkan dua endpoint JSONPlaceholder:

1. GET https://jsonplaceholder.typicode.com/users?_limit=8 menyediakan id, nama, email, dan organisasi pemohon.
2. GET https://jsonplaceholder.typicode.com/posts?_limit=8 menyediakan id, userId, title, dan body yang diperlakukan sebagai data pengajuan.

Request tidak saling bergantung, sehingga IntegrasiService memakai Future.wait untuk menjalankan kedua GET secara paralel. Setelah kedua Future selesai, service membuat map pengguna berdasarkan id, lalu mencocokkan pengajuan.userId dengan pengguna.id.

## Pemetaan field JSON ke model

| Model | Field Dart | Key JSON | Nilai cadangan |
|:------|:-----------|:---------|:--------------|
| DataPengguna | id | id | 0 |
| DataPengguna | nama | name | Nama tidak tersedia |
| DataPengguna | email | email | Email tidak tersedia |
| DataPengguna | organisasi | company.name | Organisasi tidak tersedia |
| DataPengajuan | id | id | 0 |
| DataPengajuan | userId | userId | 0 |
| DataPengajuan | judul | title | Pengajuan tanpa judul |
| DataPengajuan | status | status | Diproses atau Menunggu |
| DataPengajuan | deskripsi | body | Deskripsi tidak tersedia |

Identifier integrasi adalah userId pada DataPengajuan yang dicocokkan dengan id pada DataPengguna. Jika tidak ada pengguna dengan id tersebut, UI tetap menampilkan pengajuan dan memakai teks Pemohon tidak ditemukan.

## Diagram alur request dan response

Aplikasi Flutter
→ IntegrasiService
→ GET /users dan GET /posts secara paralel
→ JSON response
→ factory fromJson
→ map pengguna berdasarkan id
→ cocokkan pengajuan.userId dengan pengguna.id
→ List<PengajuanTerintegrasi>
→ halaman menampilkan nama pemohon, email, judul, dan status.

## Kondisi halaman

- Loading: CircularProgressIndicator tampil ketika dua request masih berjalan.
- Sukses: daftar gabungan dibaca menggunakan ListView.builder.
- Kosong: request berhasil tetapi daftar gabungan tidak memiliki item.
- Error: status HTTP, timeout, JSON rusak, atau kegagalan jaringan ditampilkan sebagai pesan informatif.
- Retry: tombol Coba Lagi menjalankan ulang proses integrasi.

## Cara menjalankan

Dari folder proyek Flutter runnable:

    cd C:\Users\ELANG\SI-VIIA-Mobile\tugas_10_web
    flutter pub get
    flutter run -d chrome

Untuk menguji error, gunakan endpoint dasar yang salah:

    flutter run -d chrome --dart-define=API_BASE_URL=https://jsonplaceholder.typicode.com/not-found

## Batasan API simulasi

JSONPlaceholder adalah API latihan, sehingga data pengajuan sebenarnya berasal dari endpoint posts dan tidak merepresentasikan database surat yang persisten. Respons POST atau perubahan data server tidak menjadi bagian Tugas 10 karena fokusnya adalah penggabungan dua sumber data. Pada sistem produksi, endpoint akan diganti dengan backend kampus yang memiliki autentikasi, status pengajuan resmi, dan penyimpanan permanen.

## Deklarasi penggunaan AI

Deklarasi penggunaan AI: ChatGPT — membantu merancang model dua endpoint, service Future.wait, parsing JSON, state halaman, jawaban quiz, dan dokumentasi; kode, pengujian, serta pemahaman akhir diperiksa dan diverifikasi oleh penulis.
