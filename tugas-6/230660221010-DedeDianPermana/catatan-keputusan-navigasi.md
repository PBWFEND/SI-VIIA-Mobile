\# Catatan Keputusan Navigasi — SiRuang Kampus



\*\*Nama:\*\* Dede Dian Permana  

\*\*NIM:\*\* 230660221010  

\*\*Kelas:\*\* SI-VIIA



\## Catatan Keputusan



| No. | Keputusan | Alasan |

|---|---|---|

| 1 | Menggunakan nama route `/ruangan`, `/detail-ruangan`, dan `/form-peminjaman`. | Nama route dibuat sesuai nama halaman pada information architecture Tugas 5 agar konsisten antara dokumentasi, diagram, dan kode. |

| 2 | Menetapkan `/ruangan` sebagai `initialRoute`. | Halaman Daftar Ruangan merupakan halaman awal pengguna dan memenuhi kebutuhan F-01 untuk melihat daftar, kategori, dan status ketersediaan ruangan. |

| 3 | Mengirim data ruangan menggunakan `Navigator.pushNamed` dan `arguments`. | Halaman Detail dan Jadwal Ruangan membutuhkan data ruangan yang dipilih dari halaman daftar untuk memenuhi kebutuhan F-02. |

| 4 | Memeriksa tipe data `arguments` dan menangani data yang tidak tersedia. | Pengecekan tipe dan kondisi data mencegah halaman detail menggunakan data yang tidak sesuai atau tidak tersedia. |

| 5 | Menyediakan tombol kembali menggunakan `Navigator.pop`. | Pengguna perlu kembali dari halaman detail ke daftar ruangan atau dari formulir ke halaman sebelumnya tanpa harus memulai ulang aplikasi. |

| 6 | Memvalidasi kolom tanggal peminjaman. | Tanggal wajib diisi agar informasi waktu pengajuan sesuai dengan kebutuhan F-03. |

| 7 | Memvalidasi kolom waktu peminjaman. | Waktu wajib diisi agar pengajuan memiliki informasi waktu penggunaan ruangan yang jelas sesuai F-03. |

| 8 | Memvalidasi kolom tujuan peminjaman. | Tujuan wajib diisi agar alasan penggunaan ruangan dapat diketahui dalam proses pengajuan F-03. |

| 9 | Menggunakan `TextEditingController` dan memanggil `dispose()`. | Controller membantu mengelola isi kolom formulir dan perlu dilepas ketika widget tidak digunakan lagi. |

| 10 | Menampilkan pesan validasi pada kolom yang belum diisi. | Pesan membantu pengguna mengetahui bagian yang harus diperbaiki sebelum formulir dikirim. |

| 11 | Menampilkan `SnackBar` setelah formulir valid dikirim. | Pengguna memperoleh umpan balik bahwa proses pengajuan pada prototipe telah disimulasikan. Pesan ini bukan bukti bahwa data telah disimpan ke database. |



\## Kesimpulan



Keputusan navigasi dan interaksi dibuat agar alur aplikasi SiRuang Kampus konsisten dengan kebutuhan F-01, F-02, dan F-03 serta information architecture Tugas 5. Implementasi ini masih berupa prototipe yang menggunakan data contoh dan belum terhubung ke database atau sistem peminjaman kampus.

