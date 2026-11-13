\# Navigation Flow — SiRuang Kampus



\*\*Nama:\*\* Dede Dian Permana  

\*\*NIM:\*\* 230660221010  

\*\*Kelas:\*\* SI-VIIA  

\*\*Domain:\*\* Sistem Informasi Peminjaman Ruang Kelas — SiRuang Kampus



\## 1. Tabel Route



| Nama Route | Nama Halaman | Requirement ID | Keterangan |

|---|---|---|---|

| `/ruangan` | Halaman Daftar Ruangan | F-01 | Halaman awal untuk melihat daftar ruangan, kategori, dan status ketersediaan. |

| `/detail-ruangan` | Halaman Detail dan Jadwal Ruangan | F-02 | Menampilkan detail ruangan dan jadwal penggunaan berdasarkan data ruangan yang dipilih. |

| `/form-peminjaman` | Halaman Formulir Peminjaman | F-03 | Formulir untuk mengisi tanggal, waktu, dan tujuan peminjaman ruangan. |



\*\*Initial Route:\*\* `/ruangan`



Route `/ruangan` ditetapkan sebagai `initialRoute` karena merupakan halaman pertama yang dibuka pengguna dan memenuhi kebutuhan Must Have F-01, yaitu melihat daftar ruangan, kategori, dan status ketersediaannya.



\## 2. Diagram Navigation Flow



```mermaid

flowchart TD

&#x20;   A\["Halaman Daftar Ruangan<br/>/ruangan — F-01"]

&#x20;   B\["Halaman Detail dan Jadwal Ruangan<br/>/detail-ruangan — F-02"]

&#x20;   C\["Halaman Formulir Peminjaman<br/>/form-peminjaman — F-03"]

&#x20;   D\["SnackBar: Pengajuan Berhasil Disimulasikan"]



&#x20;   A -->|"Pilih ruangan dan kirim data"| B

&#x20;   B -->|"Ajukan peminjaman"| C

&#x20;   B -->|"Kembali — Navigator.pop"| A

&#x20;   C -->|"Kembali — Navigator.pop"| B

&#x20;   C -->|"Form valid dan dikirim"| D

```



\## 3. Penjelasan Alur Navigasi



Pengguna memulai dari Halaman Daftar Ruangan untuk melihat ruangan, kategori, dan status ketersediaannya. Ketika pengguna memilih salah satu ruangan, aplikasi membuka Halaman Detail dan Jadwal Ruangan serta mengirimkan data ruangan melalui `arguments`. Data tersebut diperiksa menggunakan pengecekan tipe dan kondisi `null` sebelum ditampilkan.



Dari halaman detail, pengguna dapat kembali ke daftar ruangan atau melanjutkan ke Halaman Formulir Peminjaman. Pada formulir, pengguna mengisi tanggal, waktu, dan tujuan peminjaman. Setiap kolom memiliki validasi agar data wajib tidak kosong. Jika semua data valid, aplikasi menampilkan `SnackBar` sebagai umpan balik bahwa pengajuan telah disimulasikan berhasil.



\## 4. Konsistensi Navigasi



Nama route pada dokumen ini harus sama dengan nama route pada konfigurasi `MaterialApp`, pemanggilan `Navigator.pushNamed`, dan diagram navigasi. Navigasi kembali menggunakan `Navigator.pop`. Alur ini merupakan simulasi interaksi ant halaman dan belum menyimpan pengajuan ke database.

