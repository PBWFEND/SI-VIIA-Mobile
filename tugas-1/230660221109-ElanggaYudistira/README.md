# Tugas 1 - Identifikasi Kebutuhan Aplikasi Bergerak

Nama : Elangga Yudistira\
NIM : 230660221109

## 1. Deskripsi Sistem

Aplikasi Pengaduan Fasilitas Kampus merupakan aplikasi mobile yang
digunakan oleh mahasiswa untuk melaporkan permasalahan fasilitas kampus
seperti kerusakan ruang kelas, laboratorium, toilet, atau sarana umum
lainnya. Pengguna utama aplikasi adalah mahasiswa sebagai pelapor dan
petugas kampus sebagai pengelola laporan. Permasalahan yang terjadi saat
ini adalah proses penyampaian laporan masih dilakukan secara manual
sehingga informasi kerusakan sulit dipantau dan membutuhkan waktu lebih
lama untuk ditindaklanjuti. Solusi berbentuk aplikasi mobile karena
pengguna dapat melakukan pelaporan secara langsung melalui perangkat
bergerak dengan memanfaatkan karakteristik mobile berupa konteks
bergerak (mobile context) dan interaksi sentuh (touch interaction).

## 2. Diagram Arsitektur

Aplikasi Mobile Flutter → HTTP Request → Backend SI → Database → HTTP
Response → Aplikasi Mobile

## 3. Tabel Kebutuhan Sistem

  ------------------------------------------------------------------------------
  No          Permintaan   Pengguna    Karakteristik   Fitur         Materi
                                       Mobile yang     Aplikasi      Pemenuh
                                       Terkait                       
  ----------- ------------ ----------- --------------- ------------- -----------
  1           Mahasiswa    Mahasiswa   Sesi penggunaan Halaman login UI/UX dan
              dapat                    singkat untuk   dan           REST API
              melakukan                akses cepat     autentikasi   
              login                                                  
              aplikasi                                               

  2           Mahasiswa    Mahasiswa   Layar kecil     Halaman       UI dan
              melihat                  membutuhkan     daftar        Navigasi
              daftar                   tampilan        laporan       
              laporan                  ringkas                       

  3           Mahasiswa    Mahasiswa   Interaksi       Form          Form dan
              membuat                  sentuh pada     pengaduan     Validasi
              laporan                  form mobile                   
              fasilitas                                              
              rusak                                                  

  4           Mahasiswa    Mahasiswa   Menggunakan     Upload foto   Device
              mengambil                fitur kamera    laporan       Feature
              foto                     perangkat                     
              kerusakan                                              

  5           Mahasiswa    Mahasiswa   Konektivitas    Tracking      REST API
              melihat                  terbatas        laporan       
              status                   membutuhkan                   
              laporan                  pengambilan                   
                                       data efisien                  

  6           Petugas      Petugas     Bukan tugas     Pengelolaan   Di luar
              mengelola    Kampus      utama aplikasi  data backend  lingkup
              laporan                  mobile                        aplikasi
                                                                     mobile
                                                                     (backend
                                                                     SI)
  ------------------------------------------------------------------------------

## 4. Refleksi

Fitur perangkat yang paling relevan adalah kamera karena pengguna dapat
mengambil foto kerusakan fasilitas sebagai bukti laporan. Fitur lokasi
juga relevan karena membantu menentukan lokasi fasilitas yang mengalami
masalah. Pemanfaatan fitur tersebut membuat proses pelaporan lebih cepat
dan akurat.
