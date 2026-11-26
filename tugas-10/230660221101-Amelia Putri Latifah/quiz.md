# Quiz Pertemuan 10
## Soal 1 — Integrasi Data
Integrasi data pada aplikasi mobile adalah proses menghubungkan dan menyatukan data dari dua atau lebih sumber/endpoint (misalnya REST API terpisah) sehingga aplikasi dapat menyajikan satu alur proses bisnis yang utuh kepada pengguna, alih-alih menampilkan potongan data mentah secara terpisah.
-- Contoh proses bisnis Sistem Informasi (PresenGo): Pada alur rekap kehadiran dan jadwal kegiatan organisasi, endpoint daftar kegiatan/sesi menyediakan informasi agenda dan waktu/lokasi kegiatan, sedangkan endpoint data anggota/pengguna menyediakan nama anggota atau pengurus yang mengajukan/hadir. Menggabungkan keduanya memungkinkan halaman menampilkan daftar kegiatan beserta nama pemohon atau penanggung jawab secara lengkap.
-- Identifier penghubung: userId (yang merujuk pada id di model data pengguna/anggota) serta kegiatanId atau roomId (jika menghubungkan ke data kegiatan/ruang).

## Soal 2 — Future.wait
Future.wait digunakan ketika terdapat beberapa request asinkron yang independen (tidak saling bergantung) sehingga dapat dijalankan secara bersamaan (concurrent) untuk menghemat waktu tunggu total (waktu tunggu mengikuti request terlama, bukan penjumlahan seluruh durasi request). Contohnya pada PresenGo saat memuat daftar pengguna dan daftar kegiatan/pengajuan secara paralel sebelum digabungkan.
Kondisi yang mengharuskan request dijalankan secara berurutan (sequential dengan await):
-- Request kedua membutuhkan nilai atau identifier spesifik yang baru diperoleh dari hasil respons request pertama (misalnya mengambil detail kehadiran berdasarkan id kegiatan atau token/ID sesi yang baru dibuat dari request sebelumnya).
-- Ada aturan urutan proses bisnis yang mengharuskan satu operasi selesai dan tervalidasi dulu sebelum request berikutnya dikirim.

## Soal 3 — Model dan fromJson
Untuk menghubungkan data pengguna dan pengajuan pada model DataPengajuan, field yang dibutuhkan meliputi:
-- Identitas & relasi: id (identitas pengajuan) dan userId (kunci relasi ke id pengguna), serta field pendukung proses bisnis seperti namaKegiatan/judul, lokasi atau roomId, tanggal/waktu, dan status.
-- Cara fromJson menangani field yang tidak tersedia atau berbeda tipe pada response:
-- Menggunakan safe type casting (as int?, as String?) dan operator null-coalescing (??) untuk memberikan nilai default yang aman (misalnya 0 untuk id/userId, '' atau 'Tanpa Keterangan' untuk teks, dan 'menunggu' sebagai status bawaan).
-- Melakukan normalisasi/pemetaan nilai mentah dari API simulasi agar tidak memicu null check error atau type cast exception saat parsing JSON.

## Soal 4 — Service Layer
Perbedaan tanggung jawab:
-- Service layer: Bertanggung jawab atas urusan teknis data dan proses bisnis—menyusun URL, mengirim request HTTP (http.get/http.post), mengatur timeout dan try-catch, memeriksa status code, melakukan parsing JSON ke model, menggabungkan data lintas endpoint berdasarkan identifier, serta menerapkan aturan proses bisnis (seperti pemetaan status).
-- Widget (UI): Bertanggung jawab merender tampilan berdasarkan state dan meneruskan aksi pengguna (seperti membuka halaman, menekan tombol refresh atau coba lagi) ke service/handler.
-- Mengapa penggabungan data sebaiknya tidak ditulis langsung di dalam widget:
-- Menjaga keterbacaan dan keterawatan kode (separation of concerns): widget tetap ringkas dan fokus pada UI, sedangkan perubahan aturan penggabungan atau struktur API cukup diperbaiki di satu tempat (service layer).
-- Menghindari duplikasi logika jika data gabungan dipakai di lebih dari satu halaman, serta mencegah proses parsing dan pencocokan identifier tercampur di dalam siklus build tampilan.

## Soal 5 — Status Halaman
State yang perlu dikelola pada halaman integrasi data meliputi:
-- Loading (_sedangMemuat = true): saat proses pengambilan/penggabungan data sedang berjalan (CircularProgressIndicator).
-- Sukses / Ada Data (_daftar.isNotEmpty dan tanpa error): saat data berhasil dimuat dan digabungkan untuk ditampilkan pada daftar/kartu.
-- Kosong (_daftar.isEmpty dan tanpa error): saat request berhasil (200 OK) tetapi tidak ada item data yang tersedia.
-- Error (_pesanError != null): saat terjadi kegagalan jaringan, timeout, status code gagal (seperti 404/500), atau kesalahan parsing JSON, dilengkapi tombol Coba Lagi.
Mengapa kondisi data kosong perlu dibedakan dari kondisi error:
-- Secara teknis dan proses bisnis maknanya berbeda: data kosong berarti komunikasi ke server berhasil namun memang belum ada jadwal/pengajuan yang tercatat (bukan kegagalan sistem), sedangkan error berarti terjadi gangguan atau kegagalan pemrosesan data.
-- Membedakannya mencegah pengguna panik melihat pesan kegagalan sistem saat data memang belum ada, sekaligus memungkinkan penyajian pesan dan tindakan yang tepat (informasi belum ada data vs. pesan gangguan dan tombol coba lagi).